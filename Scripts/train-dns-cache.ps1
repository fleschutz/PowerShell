#!/snap/bin/powershell
<#
.SYNTAX         ./train-dns-cache.ps1
.DESCRIPTION	trains the DNS cache with frequently used domain names
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

Set-StrictMode -Version Latest

$PathToRepo = "$PSScriptRoot/.."
 
try {
	$StartTime = Get-Date

	write-progress "Reading Data/domain-names.csv..."
	$Table = import-csv "$PathToRepo/Data/domain-names.csv"

	foreach($Row in $Table) {
		$Domain = $Row.Domain
		write-progress "Training DNS cache with $Domain..."
		$Ignore = nslookup $Domain
	}

	$Count = $Table.Length
	$StopTime = Get-Date
	$TimeInterval = New-Timespan -start $StartTime -end $StopTime
	write-output "OK - DNS cache trained with $Count domain names in $TimeInterval seconds"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
