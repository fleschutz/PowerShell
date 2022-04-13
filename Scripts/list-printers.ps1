<#
.SYNOPSIS
	Lists all printers known to the local computer
.DESCRIPTION
	This PowerShell script lists all printers known to the local computer.
.EXAMPLE
	PS> ./list-printers
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$ComputerName = $(hostname)
	get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | format-table
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
