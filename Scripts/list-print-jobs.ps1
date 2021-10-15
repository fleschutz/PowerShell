<#
.SYNOPSIS
	Lists all jobs of all printers
.DESCRIPTION
	This script lists all print jobs of all printer devices.
.EXAMPLE
	PS> ./list-print-jobs
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -Version 4

try {
	$printers = Get-Printer
	if ($printers.Count -eq 0) { throw "No printer found" }

	""
	"Printer                Jobs"
	"-------                ----"
	foreach ($printer in $printers) {
		$printjobs = Get-PrintJob -PrinterObject $printer
		if ($printjobs.Count -eq 0) {
			"$($printer.Name)     none"
		} else {
			"$($printer.Name)     $printjobs"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
