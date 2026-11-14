<#
.SYNOPSIS
	Clears the Windows Explorer icon cache of the current user
.DESCRIPTION
	This PowerShell script stops Windows Explorer, deletes the icon cache
	files (iconcache_*.db and thumbcache_*.db) in the current user's
	AppData folder and restarts Windows Explorer. It requires no
	administrator rights. Useful for fixing blank or stale icons on
	Windows 11.
.EXAMPLE
	PS> ./clear-icon-cache.ps1
	Stopping Windows Explorer...
	Deleting icon cache files...
	Restarting Windows Explorer...
	✅ Icon cache cleared - Explorer restarted
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: socketz | License: CC0
#>

try {
	$Path = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"

	"Stopping Windows Explorer..."
	Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
	Start-Sleep -Seconds 2

	"Deleting icon cache files..."
	Set-Location $Path
	Remove-Item -Force -Path "iconcache_*.db", "thumbcache_*.db" -ErrorAction SilentlyContinue

	"Restarting Windows Explorer..."
	Start-Process explorer.exe

	"✅ Icon cache cleared - Explorer restarted"
	exit 0 # success
} catch {
	Start-Process explorer.exe -ErrorAction SilentlyContinue
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
