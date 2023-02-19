<#
.SYNOPSIS
	Check DNS servers
.DESCRIPTION
	This PowerShell script measures the availability and latency of public DNS servers and lists it.
.EXAMPLE
	PS> ./check-dns-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckDNSServer { param($Name, $IPv4Pri, $IPv4Sec)
	$SW = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Pri 2>$null)
	[int]$Elapsed1 = $SW.Elapsed.TotalMilliseconds

	$SW = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Sec 2>$null)
	[int]$Elapsed2 = $SW.Elapsed.TotalMilliseconds

	New-Object PSObject -Property @{ Name=$Name; IPv4="$IPv4Pri / $IPv4Sec"; Latency="$Elapsed1 / $Elapsed2 ms" }
}

function ListDNSServer {
	Write-Progress "Loading Data/dns-server-list.csv..."
      $Table = Import-CSV "$PSScriptRoot/../Data/dns-server-list.csv"
	Write-Progress "Measuring latency..."
	foreach($Row in $Table) {
		CheckDNSServer $Row.NAME $Row.IPv4_PRI $Row.IPv4_SEC	
	}
	Write-Progress -completed " "
}
 
try {
	ListDNSServer | Format-Table -property @{e='Name';width=50},@{e='IPv4';width=32},@{e='Latency';width=15}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}