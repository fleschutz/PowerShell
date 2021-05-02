<#
.SYNTAX       check-dns-resolution.ps1
.DESCRIPTION  checks the DNS resolution with frequently used domain names
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>
 
try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	write-progress "Reading Data/domain-names.csv..."

	$PathToRepo = "$PSScriptRoot/.."
	$Table = import-csv "$PathToRepo/Data/domain-names.csv"

	foreach($Row in $Table) {
		write-progress "Resolving $($Row.Domain) ..."
		if ($IsLinux) {
			$Ignore = nslookup $Row.Domain
		} else {
			$Ignore = resolve-dnsName $Row.Domain
		}
	}
	$Count = $Table.Length

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($Count / $Elapsed, 1)
	"✔️ $Average domains/s ($Count domains resolved in $Elapsed sec.)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
