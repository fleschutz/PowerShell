<#
.SYNOPSIS
	Starts a Calibre server
.DESCRIPTION
	This PowerShell script starts a local Calibre server as background process (using Web port 8099 by default).
.PARAMETER port
	Specifies the Web port number (8099 by default)
.EXAMPLE
	PS> ./start-calibre-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$Port = 8099, [string]$UserDB = "$HOME/CalibreUsers.sqlite", [string]$Logfile = "$HOME/CalibreServer.log")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/2: Searching for Calibre server executable..."
	& calibre-server --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

	"⏳ Step 2/2: Starting Calibre server..."
	"  configured is Web port: $Port, user DB: $UserDB, log file: $Logfile"
	& calibre-server --port $Port --num-per-page 100 --userdb $UserDB --log $Logfile --daemonize $HOME/'Calibre Library'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ started Calibre server as background process in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
