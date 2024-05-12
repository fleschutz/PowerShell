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
	if (-not $IsLinux) { throw "Sorry, currently only supported on Linux" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/5) Updating package infos..."
	& sudo apt update -y
	if ($lastExitCode -ne "0") { throw "'apt update' failed" }

	"⏳ (2/5) Installing Calibre package..."
	& sudo apt install calibre -y
	if ($lastExitCode -ne "0") { throw "'apt install calibre' failed" }

	Write-Host "⏳ (3/5) Searching for Calibre server executable...    " -noNewline
	& calibre-server --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

	"⏳ (4/5) Creating media folder at: $mediaFolder ... (if non-existent)"
	mkdir $mediaFolder

	"⏳ (5/5) Starting Calibre server as background process..."
	& calibre-server --port $port --num-per-page 100 --userdb $userDB --log $logfile --daemonize $HOME/'Calibre Library'

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Installed Calibre server on port $port in $($elapsed)s (media at: $mediaFolder, user DB: $userDB, log to: $logfile)"
	exit 0 # success
} catch {
"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
exit 1
}
