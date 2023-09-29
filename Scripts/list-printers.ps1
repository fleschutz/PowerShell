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
		$ComputerName = $(hostname)
		Get-WMIObject -Class Win32_Printer -ComputerName $ComputerName | Format-Table
		"(PrinterStatus: 1=various 2=unknown 3=idle 4=printing 5=warmup 6=finished 7=offline)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
