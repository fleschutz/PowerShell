<#
.SYNOPSIS
	Installs the Calibre server (needs admin rights)
.DESCRIPTION
	This PowerShell script installs and starts a local Calibre server as background process.
.PARAMETER port
	Specifies the Web port number (8099 by default)
.PARAMETER mediaFolder
	Specifies the file path to the media ('/opt/Calibre Library' by default)
.PARAMETER userDB
	Specifies the file path to the user database ('/opt/CalibreUsers.sqlite' by default)
.PARAMETER logfile
	Specifies the file path to the log file ('/opt/CalibreServer.log' by default)
.EXAMPLE
	PS> ./install-calibre-server.ps1
	⏳ (1/5) Updating package infos...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1 -RunAsAdministrator

param([int]$port = 8099, [string]$mediaFolder = "/opt/Calibre Library", [string]$userDB = "/opt/CalibreUsers.sqlite", [string]$logfile = "/opt/CalibreServer.log")

try {
	if (-not $IsLinux) { throw "Sorry, currently only supported on Linux" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"`n⏳ (1/5) Updating package infos..."
	& sudo apt update -y
	if ($lastExitCode -ne 0) { throw "'apt update' failed" }

	"`n⏳ (2/5) Installing Calibre package..."
	& sudo apt install calibre -y
	if ($lastExitCode -ne 0) { throw "'apt install calibre' failed" }

	"`n⏳ (3/5) Searching for Calibre server executable..." 
	& calibre-server --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'calibre-server' - make sure Calibre server is installed and available" }

	"`n⏳ (4/5) Creating media folder at: $mediaFolder ... (if non-existent)"
	& mkdir $mediaFolder

	"`n⏳ (5/5) Starting Calibre server as background process..."
	& nohup sudo calibre-server --port $port --num-per-page 100 --userdb $userDB --log $logfile --disable-use-bonjour $mediaFolder &

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Calibre server installed in $($elapsed)s."
	"   (URL=http://$(hostname):$port media=$mediaFolder userDB=$userDB log=$logfile)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
