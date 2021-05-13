<#
.SYNTAX       list-news.ps1 [<RSS-URL>] [<max-count>]
.DESCRIPTION  lists the latest news
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 20)

try {
	[xml]$Content = (invoke-webRequest -uri $RSS_URL -useBasicParsing).Content
	"`n🌍 $($Content.rss.channel.title) 🌏"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"→ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
