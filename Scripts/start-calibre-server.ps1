<#
.SYNOPSIS
	Starts a local Calibre server
.DESCRIPTION
	This PowerShell script starts a local Calibre server as background process (Web port number is 8099 by default).
.PARAMETER port
	Specifies the Web port number (8099 by default)
.EXAMPLE
	PS> ./start-calibre-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([int]$port = 8099)

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"Step 1/2: Searching for Calibre server executable..."
	& calibre-server --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

	"Step 2/2: Starting Calibre server as background process..."
	& calibre-server --port $port --num-per-page 100 --userdb $HOME/CalibreUsers.sqlite --log $HOME/CalibreServer.log --daemonize $HOME/'Calibre Library'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ started Calibre server with port $port in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
