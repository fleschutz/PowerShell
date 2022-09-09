<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script checks the DNS resolution using frequently used domain names.
.EXAMPLE
	PS> ./check-dns
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	"⏳ Step 1/2 - Reading table from Data/domains.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/domains.csv"
	$NumRows = $Table.Length

	"⏳ Step 2/2 - Resolving $NumRows domains..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($Row in $Table) { $null = dig $Row.Domain +short }
	} else {
		foreach($Row in $Table) { $null = Resolve-DNSName $Row.Domain }
	}

	[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($NumRows / $Elapsed, 1)
	if ($Average -gt 200.0) { $Rating = "excellent" 
	} elseif ($Average -gt 100.0) { $Rating = "quite good"
	} elseif ($Average -gt 10.0) { $Rating = "good"
	} else { $Rating = "poor"
	}
	"✔️ $Average DNS domain lookups per second - $Rating"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}