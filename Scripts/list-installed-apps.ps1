<#
.SYNOPSIS
	list-installed-apps.ps1
.DESCRIPTION
	Lists the installed Windows Store apps.
.EXAMPLE
	PS> .\list-installed-apps.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-appxPackage | select-object Name,Version | format-table -autoSize
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
