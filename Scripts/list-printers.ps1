<#
.SYNOPSIS
	Lists all printers known to the local computer
.DESCRIPTION
	This script lists all printers known to the local computer.
.EXAMPLE
	PS> ./list-printers
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$ComputerName = $(hostname)
	get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | format-table
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
