<#
.SYNTAX       list-printers.ps1
.DESCRIPTION  lists all printer known to the computer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$ComputerName = $(hostname)
	get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | format-table
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
