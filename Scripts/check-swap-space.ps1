<#
.SYNOPSIS
	Checks the swap space
.DESCRIPTION
	This PowerShell script checks the free swap space.
.PARAMETER MinLevel
	Specifies the minimum level (50 GB by default)
.EXAMPLE
	PS> ./check-swap-space
	✔️ 1213 GB left for swap space (67 of 1280 GB used)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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

	if ($Total -eq "0") {
        	$Reply = "No swap space configured!"
	} elseif ($Free -lt $MinLevel) {
        	$Reply = "Swap space has only $Free GB left to use! ($Used of $Total GB used, minimum is $MinLevel GB)"
	} else {
		$Reply = "Swap space has $Free GB left ($Total GB total)"
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
