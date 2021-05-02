<#
.SYNTAX       list-os-updates.ps1 [<RSS-URL>] [<max-count>]
.DESCRIPTION  lists the latest operating system updates
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RSS_URL = "https://distrowatch.com/news/dwd.xml", [int]$MaxCount = 20)

try {
	& "$PSScriptRoot/write-big.ps1" "OS Updates"
	[xml]$Content = (invoke-webRequest -URI $RSS_URL).Content
	"`t(by $($Content.rss.channel.title))"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"`t→ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
