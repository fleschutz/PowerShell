<#
.SYNOPSIS
	Installs the Calibre server (needs admin rights)
.DESCRIPTION
	This PowerShell script installs and starts a local Calibre server as background process.
.PARAMETER port
	Specifies the Web port number (8099 by default)
.EXAMPLE
	PS> ./install-calibre-server.ps1
	⏳ (1/5) Updating package infos...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

param([int]$port = 8099, [string]$mediaFolder = "$HOME/Calibre Library", [string]$userDB = "$HOME/CalibreUsers.sqlite", [string]$logfile = "$HOME/CalibreServer.log")

try {
	if ($IsLinux) {
		$stopWatch = [system.diagnostics.stopwatch]::startNew()

		"⏳ (1/5) Updating package infos..."
		& sudo apt update -y
		if ($lastExitCode -ne "0") { throw "'apt update' failed" }

		"⏳ (2/5) Installing Calibre..."
		& sudo apt install calibre -y
		if ($lastExitCode -ne "0") { throw "'apt install calibre' failed" }

		"⏳ (3/5) Searching for Calibre server executable..."
		& calibre-server --version
		if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

		"⏳ (4/5) Creating media folder at: $mediaFolder ... (if non-existent)"
		mkdir $mediaFolder

		"⏳ (5/5) Starting Calibre server as background process..."
		& calibre-server --port $port --num-per-page 100 --userdb $userDB --log $logfile --daemonize $HOME/'Calibre Library'

		[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
		"✔️ Installed Calibre server on Web port $port in $elapsed sec (media folder: $mediaFolder, user database: $userDB, log file: $logfile)"
		exit 0 # success
	} else {
		throw "Currently only supported on Linux"
	}
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
