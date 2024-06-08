<#
.SYNOPSIS
	Sets the working directory to the 'recent' folder
.DESCRIPTION
	This PowerShell script changes the working directory to the 'recent' folder.
.EXAMPLE
	PS> ./cd-recent
	📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Recent
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = [Environment]::GetFolderPath('Recent')
	if (-not(Test-Path "$path" -pathType container)) {
		throw "Recent folder at 📂$path doesn't exist (yet)"
	}
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
