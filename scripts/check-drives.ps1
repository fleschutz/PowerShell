<#
.SYNOPSIS
	Checks the drive space
.DESCRIPTION
	This PowerShell script queries the free space of all drives and prints it.
.PARAMETER minLevel
	Specifies the minimum warning level (10 GB by default)
.EXAMPLE
	PS> ./check-drives.ps1
	✅ Drive C: uses 49% of 1TB · 512GB free
	✅ Drive D: uses 84% of 4TB · 641GB free
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int64]$minLevel = 10) # 10 GB minimum

function Bytes2String { param([int64]$bytes)
        if ($bytes -lt 1000) { return "$bytes bytes" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)KB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)MB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)GB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)TB" }
        $bytes /= 1000
        return "$($bytes)PB"
}

try {
	Write-Progress "Querying drives..."
	$drives = Get-PSDrive -PSProvider FileSystem
	$minLevel *= 1000 * 1000 * 1000
	Write-Progress -completed " "
	foreach($drive in $drives) {
		$details = (Get-PSDrive $drive.Name)
		if ($IsLinux) { $name = $drive.Name } else { $name = $drive.Name + ":" }
		[int64]$free = $details.Free
 		[int64]$used = $details.Used
		[int64]$total = ($used + $free)

		if ($total -eq 0) {
			Write-Host "✅ Drive $name is empty"
		} elseif ($free -eq 0) {
			Write-Host "⚠️ Drive $name with $(Bytes2String $total) is full"
		} elseif ($free -lt $minLevel) {
			Write-Host "⚠️ Drive $name with $(Bytes2String $total) is nearly full, $(Bytes2String $free) free"
		} else {
			[int]$percent = ($used * 100) / $total
			Write-Host "✅ Drive $name uses $percent% of $(Bytes2String $total) · $(Bytes2String $free) free"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
