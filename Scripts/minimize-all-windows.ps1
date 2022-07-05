<#
.SYNOPSIS
	Minimizes all windows
.DESCRIPTION
	This PowerShell script minimizes all open windows.
.EXAMPLE
	PS> ./minimize-all-windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$shell = New-Object -ComObject "Shell.Application"
	$shell.minimizeall()
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
