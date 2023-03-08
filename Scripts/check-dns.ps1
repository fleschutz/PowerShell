<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed by using 200 popular domains.
.EXAMPLE
	PS> ./check-dns
	✅ DNS resolution is 440.5 domains per second
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	Write-Progress "⏳ Resolving 200 popular domains..."
	$Table = Import-CSV "$PSScriptRoot/../Data/popular-domains.csv"
	$NumRows = $Table.Length

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($Row in $Table){$nop=dig $Row.Domain +short}
	} else {
		foreach($Row in $Table){$nop=Resolve-DNSName $Row.Domain}
	}
	[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds

	$Average = [math]::round($NumRows / $Elapsed, 1)
	if ($Average -gt 10.0) {
		"✅ DNS resolution is $Average domains per second"
	} else {  
		"⚠️ DNS resolution is $Average domains per second only!"
	}
	Write-Progress -completed "Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}