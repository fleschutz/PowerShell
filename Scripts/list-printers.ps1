<#
.SYNOPSIS
	list-printers.ps1
.DESCRIPTION
	Lists all printer known to the local computer.
.EXAMPLE
	PS> .\list-printers.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$ComputerName = $(hostname)
	get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | format-table
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
