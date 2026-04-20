<#
.SYNOPSIS
	Sets the working directory to the logs folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the logs directory.
.EXAMPLE
	PS> ./cd-logs.ps1
	📂/var/logs entered, has 3 files and 2 folders.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function GetLogsDir {
	if ($IsLinux -or $IsMacOS) { return "/var/logs" }
	$WinDir = [System.Environment]::GetFolderPath('Windows')
	return "$WinDir\Logs"
}

try {
	$path = GetLogsDir
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered, has $($files.Count) files and $($folders.Count) folders."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
