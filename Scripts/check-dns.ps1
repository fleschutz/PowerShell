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
	"✔️ DNS resolution is $Average domains per second"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}