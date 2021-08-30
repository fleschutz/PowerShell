#requires -version 4
<#
.SYNOPSIS
	list-print-jobs.ps1
.DESCRIPTION
	Lists all jobs from all printers
.EXAMPLE
	PS> .\list-print-jobs.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$printers = Get-Printer
	if ($printers.Count -eq 0) { throw "No printer found" }
		
	foreach ($printer in $printers) {
		$printjobs = Get-PrintJob -PrinterObject $printer
		"$printer"
		"$printjobs"
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
