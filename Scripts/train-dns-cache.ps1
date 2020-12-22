#!/snap/bin/powershell

# Syntax:	./train-dns-cache.ps1
# Description:	trains the DNS cache with frequently used domain names
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
try {
	$StartTime = Get-Date

	$PathToData=(get-item $MyInvocation.MyCommand.Path).directory
	$PathToData="$PathToData/../Data"
	$Table = import-csv "$PathToData/domain_table.csv"

	foreach($Row in $Table) {
		$Domain = $Row.Domain
		Write-Progress "Training DNS cache with $Domain..."
		$Ignore = nslookup $Domain
	}

	$Count = $Table.Length
	$StopTime = Get-Date
	$TimeInterval = New-Timespan -start $StartTime -end $StopTime
	Write-Output "OK - DNS cache trained with $Count domain names in $TimeInterval seconds"
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
