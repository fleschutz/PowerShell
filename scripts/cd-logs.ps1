<#
.SYNOPSIS
	Sets the working directory to the logs folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the logs directory.
.EXAMPLE
	PS> ./cd-logs
	📂/var/logs
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetLogsDir {
	if ($IsLinux) { return "/var/logs" }
	$WinDir = [System.Environment]::GetFolderPath('Windows')
	return "$WinDir\Logs"
}

try {
	$Path = GetLogsDir
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}