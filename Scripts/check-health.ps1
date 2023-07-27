<#
.SYNOPSIS
	Checks the system health 
.DESCRIPTION
	This PowerShell script queries the system health of the local computer (hardware, software, and network) and prints it.
.EXAMPLE
	PS> ./check-health.ps1
  
	H A R D W A R E
	✅ Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (CPU0, 2701MHz, socket U3E1, 30.1°C)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/check-hardware.ps1"
& "$PSScriptRoot/check-software.ps1"
& "$PSScriptRoot/check-network.ps1"
exit 0 # success