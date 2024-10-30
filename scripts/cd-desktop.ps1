<#
.SYNOPSIS
	Sets the working directory to the user's desktop folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's desktop folder.
.EXAMPLE
	PS> ./cd-desktop
	📂/home/Markus/Desktop
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Desktop"
	} else {
		$path = [Environment]::GetFolderPath('DesktopDirectory')
	}
	if (Test-Path "$path" -pathType container) {
		Set-Location "$path"
		"📂$path"
		exit 0 # success
	}
	throw "User's desktop folder at 📂$path doesn't exist (yet)"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
