The *list-print-jobs.ps1* Script
===========================

This PowerShell script lists all print jobs of all printer devices.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/list-print-jobs.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-print-jobs.ps1



Printer                       Jobs
-------                       ----
ET-2810 Series 		      none
...

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Lists all print jobs
.DESCRIPTION
	This PowerShell script lists all print jobs of all printer devices.
.EXAMPLE
	PS> ./list-print-jobs.ps1

	Printer                       Jobs
	-------                       ----
	ET-2810 Series 		      none
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -Version 4

function ListPrintJobs {
	$printers = Get-Printer
	if ($printers.Count -eq 0) { throw "No printer found" }

	foreach ($printer in $printers) {
		$PrinterName = $printer.Name
		$printjobs = Get-PrintJob -PrinterObject $printer
		if ($printjobs.Count -eq 0) {
			$PrintJobs = "none"
		} else {
			$PrintJobs = "$printjobs"
		}
		New-Object PSObject -Property @{ Printer=$PrinterName; Jobs=$PrintJobs }
	}
}

try {
	if ($IsLinux) {
		# TODO
	} else {
		ListPrintJobs | Format-Table -property Printer,Jobs
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:38)*
