<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script measures and prints the DNS resolution speed by using 200 popular domains.
.EXAMPLE
	PS> ./check-dns
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	Write-Progress "⏳ (1/2) Loading Data/popular-domains.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/popular-domains.csv"
	$NumRows = $Table.Length

	Write-Progress "⏳ (2/2) Resolving $NumRows domains..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($Row in $Table){$nop=dig $Row.Domain +short}
	} else {
		foreach($Row in $Table){$nop=Resolve-DNSName $Row.Domain}
	}
	[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds

	Write-Progress -Completed " "
	$Average = [math]::round($NumRows / $Elapsed, 1)
	if ($Average -gt 100.0) {
		"✅ DNS resolves excellent $Average domains per second"
	} elseif ($Average -gt 10.0) {
		"✅ DNS resolves $Average domains per second"
	} else {  
		"⚠️ DNS resolves only $Average domains per second!"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
