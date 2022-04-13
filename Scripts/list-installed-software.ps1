<#
.SYNOPSIS
	Lists the installed software
.DESCRIPTION
	This PowerShell script lists the installed software (except Windows Store apps).
.EXAMPLE
	PS> ./list-installed-software
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-itemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | select-object DisplayName,DisplayVersion,InstallDate | format-table -autoSize

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
