<#
.SYNOPSIS
	Sets the working directory to the templates folder
.DESCRIPTION
	This PowerShell script changes the working directory to the templates folder.
.EXAMPLE
	PS> ./cd-templates
	📂/home/Markus/Templates
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Path = Resolve-Path "~/Templates"
	} else {
		$Path = [Environment]::GetFolderPath('Templates')
	}
	if (Test-Path "$Path" -pathType container) {
		Set-Location "$Path"
		"📂$Path"
		exit 0 # success
	}
	throw "Templates folder at 📂$Path doesn't exist (yet)"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}