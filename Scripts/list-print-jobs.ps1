<#
.SYNOPSIS
	Lists all jobs of all printers
.DESCRIPTION
	This PowerShell script lists all print jobs of all printer devices.
.EXAMPLE
	PS> ./list-print-jobs
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
