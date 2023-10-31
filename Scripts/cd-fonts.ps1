<#
.SYNOPSIS
	Sets the working directory to the fonts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the fonts folder.
.EXAMPLE
	PS> ./cd-fonts
	📂C:\Windows\Fonts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Path = [Environment]::GetFolderPath('Fonts')
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Fonts folder at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
