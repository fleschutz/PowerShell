<#
.SYNOPSIS
	Sets the working directory to the user's desktop folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's desktop folder.
.EXAMPLE
	PS> ./cd-desktop
	📂/home/Joe/Desktop
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$Path = resolve-path "$HOME/Desktop"
	} else {
		$Path = [Environment]::GetFolderPath('DesktopDirectory')
	}
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Desktop folder at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
