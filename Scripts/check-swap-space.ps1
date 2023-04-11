<#
.SYNOPSIS
	Checks the swap space status
.DESCRIPTION
	This PowerShell script queries the status of the swap space and prints it.
.PARAMETER MinLevel
	Specifies the minimum level (10 GB by default)
.EXAMPLE
	PS> ./check-swap-space
	✅ Swap space uses 63GB of 1856GB
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$MinLevel = 10) # minimum level in GB

function MB2String { param([int64]$Bytes)
        if ($Bytes -lt 1000) { return "$($Bytes)MB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)GB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)TB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)PB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)EB" }
}

try {
	[int]$Total = [int]$Used = [int]$Free = 0
	if ($IsLinux) {
		$Result = $(free --mega | grep Swap:)
		[int]$Total = $Result.subString(5,14)
		[int]$Used = $Result.substring(20,13)
		[int]$Free = $Result.substring(32,11)
	} else {
		$Items = Get-WmiObject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost 
		foreach ($Item in $Items) { 
			$Total = $Item.AllocatedBaseSize
			$Used = $Item.CurrentUsage
			$Free = ($Total - $Used)
		} 
	}
	if ($Total -eq 0) {
        	$Reply = "⚠️ No swap space configured!"
	} elseif ($Free -eq 0) {
		$Reply = "⚠️ Swap space of $(MB2String $Total) is full!"
	} elseif ($Free -lt $MinLevel) {
		$Reply = "⚠️ Swap space of $(MB2String $Total) is nearly full ($(MB2String $Free) free)!"
	} elseif ($Used -eq 0) {
		$Reply = "✅ Swap space with $(MB2String $Total) reserved"
	} elseif ($Used -lt $Free) {
		$Reply = "✅ Swap space uses $(MB2String $Used) of $(MB2String $Total)"
	} else {
		$Reply = "✅ Swap space has $(MB2String $Free) of $(MB2String $Total) free"
	}
	Write-Host $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}