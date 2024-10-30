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
		$path = Resolve-Path "~/Templates"
	} else {
		$path = [Environment]::GetFolderPath('Templates')
	}
	if (-not(Test-Path "$path" -pathType container)) { throw "Templates folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
