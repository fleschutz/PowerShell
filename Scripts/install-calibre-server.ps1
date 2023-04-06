<#
.SYNOPSIS
	Installs Calibre server (needs admin rights)
.DESCRIPTION
	This PowerShell script installs and starts a local Calibre server as background process (using Web port 8099 by default).
.PARAMETER port
	Specifies the Web port number (8099 by default)
.EXAMPLE
	PS> ./install-calibre-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

param([int]$Port = 8099, [string]$UserDB = "$HOME/CalibreUsers.sqlite", [string]$Logfile = "$HOME/CalibreServer.log")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/5) Updating package infos..."
	& sudo apt update -y
	if ($lastExitCode -ne "0") { throw "'apt update' failed" }

	"⏳ (2/5) Installing the Calibre package..."
	& sudo apt install calibre -y
	if ($lastExitCode -ne "0") { throw "'apt install calibre' failed" }

	"⏳ (3/5) Searching for Calibre server executable..."
	& calibre-server --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

	"⏳ (4/5) Creating folder 'Calibre Library' in your home directory..."
	mkdir $HOME/'Calibre Library'

	"⏳ (5/5) Starting Calibre server as background process..."
	& calibre-server --port $Port --num-per-page 100 --userdb $UserDB --log $Logfile --daemonize $HOME/'Calibre Library'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Calibre in $Elapsed sec (Web port $Port, user DB at $UserDB, log file at $Logfile)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
