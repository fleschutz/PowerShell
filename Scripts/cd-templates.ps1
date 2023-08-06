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
	if (-not(Test-Path "$Path" -pathType container)) { throw "Templates folder at 📂$Path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
