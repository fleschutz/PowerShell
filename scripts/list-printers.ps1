<#
.SYNOPSIS
	Lists the printers 
.DESCRIPTION
	This PowerShell script lists all printers known to the local computer.
.EXAMPLE
	PS> ./list-printers.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		# $ComputerName = $(hostname)
		# Get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | Format-Table
		Get-Printer * | Select-Object Name,Type,Location,Comment,DriverName,PrinterStatus | Format-Table -autoSize
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
