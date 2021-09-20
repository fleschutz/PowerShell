<#
.SYNOPSIS
	start-calibre-server.ps1 [<port>]
.DESCRIPTION
	Starts a local Calibre server as background process (Web port number is 8099 by default).
.EXAMPLE
	PS> .\start-calibre-server.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]port = 8099)

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"Step 1/2: Searching for Calibre Server executable..."
	& calibre-server --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre is installed and available" }

	"Step 2/2: Starting Calibre Server as background process..."
	& calibre-server --port $port --num-per-page 100 --userdb $HOME/CalibreUsers.sqlite --log $HOME/CalibreServer.log --daemonize $HOME/'Calibre Library'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ started Calibre Server with port $port in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
