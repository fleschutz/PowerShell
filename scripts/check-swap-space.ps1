<#
.SYNOPSIS
	Checks the swap space
.DESCRIPTION
	This PowerShell script queries the current status of the swap space and prints it.
.PARAMETER minLevel
	Specifies the minimum level in GB (10 GB by default)
.EXAMPLE
	PS> ./check-swap-space.ps1
	✅ Swap space uses 42% of 1GB · 748MB free
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$minLevel = 10)

function MB2String { param([int64]$bytes)
        if ($bytes -lt 1000) { return "$($bytes)MB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)GB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)TB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)PB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)EB" }
}

try {
	
	if ($IsLinux) {
		$Result = $(free --mega | grep Swap:)
		[int64]$total = $Result.subString(5,14)
		[int64]$used = $Result.substring(20,13)
		[int64]$free = $Result.substring(32,11)
	} else {
		$items = Get-WmiObject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost 
		[int64]$total = [int64]$used = 0
		foreach ($item in $items) { 
			$total += $item.AllocatedBaseSize
			$used += $item.CurrentUsage
			
		}
		[int64]$free = ($total - $used)
	}
	if ($total -eq 0) {
        	Write-Output "⚠️ No swap space configured"
	} elseif ($free -eq 0) {
		Write-Output "⚠️ Swap space of $(MB2String $total) is full"
	} elseif ($free -lt $minLevel) {
		Write-Output "⚠️ Swap space of $(MB2String $total) is nearly full, only $(MB2String $free) free"
	} elseif ($used -lt 5) {
		Write-Output "✅ Swap space unused, $(MB2String $free) free"
	} else {
		[int]$Percent = ($used * 100) / $total
		Write-Output "✅ Swap space uses $Percent% of $(MB2String $total) · $(MB2String $free) free"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
