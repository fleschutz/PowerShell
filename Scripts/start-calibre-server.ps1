<#
.SYNOPSIS
	start-calibre-server.ps1
.DESCRIPTION
	Starts a local Calibre server as a daemon process.
.EXAMPLE
	PS> .\start-calibre-server.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Result = (calibre-server --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre is installed and available" }

	& calibre-server --port 8099 --num-per-page 100 --userdb $HOME/CalibreUsers.sqlite --log $HOME/CalibreServer.log --daemonize $HOME/'Calibre Library'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ started Calibre Server in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
