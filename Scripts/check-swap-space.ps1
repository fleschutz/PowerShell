#!/bin/powershell
<#
.SYNTAX         ./check-swap-space.ps1 [<min-level>]
.DESCRIPTION	checks the free swap space 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([int]$MinLevel = 50) # minimum level in GB

try {
	$Items = get-wmiobject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost 
 
	foreach ($Item in $Items) { 
		$Total = $Item.AllocatedBaseSize
		$Current = $Item.CurrentUsage
		$FreeSpace = ($Total - $Current)
	} 
	if ($FreeSpace -lt $MinLevel) {
        	write-warning "Swap space has only $FreeSpace GB left to use! ($Current GB out of $Total GB in use, minimum is $MinLevel GB)"
		exit 1
	}
	write-host -foregroundColor green "OK - swap space has $FreeSpace GB left to use ($Current GB out of $Total GB in use, minimum is $MinLevel GB)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
