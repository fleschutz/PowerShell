﻿<#
.SYNOPSIS
	Lists motherboard details
.DESCRIPTION
	This PowerShell script lists the motherboard details.
.EXAMPLE
	PS> ./check-motherboard.ps1
	✅ Motherboard Calla_LC by LN
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
	} else {
		$details = Get-WmiObject -Class Win32_BaseBoard
		"✅ Motherboard $($details.Product) by $($details.Manufacturer)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
