<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed by using 200 frequently used domain names.
.EXAMPLE
	PS> ./check-dns
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	Write-Progress "⏳ Step 1/2 - Reading from Data/frequent-domains.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/frequent-domains.csv"
	$NumRows = $Table.Length

	Write-Progress "⏳ Step 2/2 - Resolving $NumRows domains..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($Row in $Table) { $null = dig $Row.Domain +short }
	} else {
		foreach($Row in $Table) { $null = Resolve-DNSName $Row.Domain }
	}

	[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($NumRows / $Elapsed, 1)

	if ($Average -gt 200.0) {
		"✅ $Average DNS domain lookups per second - excellent"
	} elseif ($Average -gt 100.0) {
		"✅ $Average DNS domain lookups per second - quite good"
	} elseif ($Average -gt 10.0) {
		"✅ $Average DNS domain lookups per second - good"
	} else {  
		"⚠️ $Average DNS domain lookups per second - poor"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
