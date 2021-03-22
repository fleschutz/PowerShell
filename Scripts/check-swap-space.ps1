#!/bin/powershell
<#
.SYNTAX       ./check-swap-space.ps1 [<min-level>]
.DESCRIPTION  checks the free swap space 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param([int]$MinLevel = 50) # minimum level in GB

try {
	if ($IsLinux) {
		$Result = $(free --mega | grep Swap:)
		[int]$Total = $Result.subString(5,14)
		[int]$Used = $Result.substring(20,13)
		[int]$Free = $Result.substring(31,12)
	} else {
		$Items = get-wmiobject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost 
		foreach ($Item in $Items) { 
			[int]$Total = $Item.AllocatedBaseSize
			[int]$Used = $Item.CurrentUsage
			[int]$Free = ($Total - $Used)
		} 
	}

	if ($Free -lt $MinLevel) {
        	write-warning "Swap space has only $Free GB left to use! ($Used GB out of $Total GB in use, minimum is $MinLevel GB)"
		exit 1
	}
	write-host -foregroundColor green "OK - swap space has $Free GB left ($Used GB of $Total GB used)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
