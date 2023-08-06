<#
.SYNOPSIS
	Checks the drive space
.DESCRIPTION
	This PowerShell script checks all drives for free space left.
.PARAMETER MinLevel
	Specifies the minimum warning level (10 GB by default)
.EXAMPLE
	PS> ./check-drives.ps1
	✅ Drive C: with 250GB at 10%, 225GB free
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$MinLevel = 10) # 10 GB minimum

function Bytes2String { param([int64]$Bytes)
        if ($Bytes -lt 1000) { return "$Bytes bytes" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)KB" }
        $Bytes /= 1000
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
	Write-Progress "⏳ Querying drives..."
	$Drives = Get-PSDrive -PSProvider FileSystem
	Write-Progress -completed "."
	foreach($Drive in $Drives) {
		$Details = (Get-PSDrive $Drive.Name)
		if ($IsLinux) { $ID = $Drive.Name } else { $ID = $Drive.Name + ":" }
		[int64]$Free = $Details.Free
 		[int64]$Used = $Details.Used
		[int64]$Total = ($Used + $Free)

		if ($Total -eq 0) {
			Write-Host "✅ Drive $ID is empty"
		} elseif ($Free -eq 0) {
			Write-Host "⚠️ Drive $ID with $(Bytes2String $Total) is 100% full"
		} elseif ($Free -lt $MinLevel) {
			Write-Host "⚠️ Drive $ID with $(Bytes2String $Total) is nearly full, $(Bytes2String $Free) free"
		} else {
			[int]$Percent = ($Used * 100) / $Total
			if ($Percent -gt 90) {
				Write-Host "✅ Drive $ID with $(Bytes2String $Total) is $Percent% full, $(Bytes2String $Free) free"
			} else {
				Write-Host "✅ Drive $ID with $(Bytes2String $Total) at $Percent%, $(Bytes2String $Free) free"
			}
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
