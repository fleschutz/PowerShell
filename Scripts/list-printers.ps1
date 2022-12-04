<#
.SYNOPSIS
	Lists the printers 
.DESCRIPTION
	This PowerShell script lists all printers known to the local computer.
.EXAMPLE
	PS> ./list-printers
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
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
