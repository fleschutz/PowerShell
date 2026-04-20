<#
.SYNOPSIS
	Clears caches
.DESCRIPTION
	This PowerShell script empties some caches on the local computer.
.EXAMPLE
	PS> ./clear-caches.ps1
	✅ Caches cleared in 1s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Clearing DNS client cache..."
	Clear-DnsClientCache

	"⏳ Clearing Windows Prefetch..."
	Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

	"⏳ Clearing Windows Temp..."
	Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ Clearing User Temp..."
	Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ Clearing Internet Explorer Cache..."
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Caches cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
