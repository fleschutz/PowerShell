#!/bin/powershell
<#
.SYNTAX         ./check-swap-space.ps1 [<warning-level>]
.DESCRIPTION	checks the swap space
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([int]$WarningLevel = 50) # warning level in GB

try {
	$colItems = get-wmiobject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost 
 
	foreach ($objItem in $colItems) { 
		$allocate = $objItem.AllocatedBaseSize
		$current = $objItem.CurrentUsage
	} 
	write-host ($allocate - $current)
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
