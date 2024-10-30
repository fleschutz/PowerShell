<#
.SYNOPSIS
	Sets the working directory to the user's music folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's music folder.
.EXAMPLE
	PS> ./cd-music
	📂C:\Users\Markus\Music
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Music"
	} else {
		$path = [Environment]::GetFolderPath('MyMusic')
	}
	if (Test-Path "$path" -pathType container) {
		Set-Location "$path"
		"📂$path"
		exit 0 # success
	}
	throw "User's music folder at 📂$path doesn't exist (yet)"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
