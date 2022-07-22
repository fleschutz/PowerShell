<#
.SYNOPSIS
	Sets the working directory to the user's screenshots folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's screenshots folder.
.EXAMPLE
	PS> ./cd-screenshots
	📂C:\Users\Markus\Pictures\Screenshots
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Path = Resolve-Path "$HOME/Pictures/Screenshots"
	} else {
		$Path = [Environment]::GetFolderPath('MyPictures')
		$Path = "$Path\Screenshots"
	}
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Screenshots folder at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}