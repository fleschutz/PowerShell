<#
.SYNOPSIS
	Clears the DNS cache
.DESCRIPTION
	This PowerShell script empties the DNS client cache of the local computer.
.EXAMPLE
	PS> ./clear-dns-cache.ps1
	✅ DNS cache cleared in 1s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Clear-DnsClientCache

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ DNS cache cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
