<#
.SYNTAX       list-news.ps1 [<RSS-URL>]
.DESCRIPTION  lists the latest news
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RSS_URL = "https://yahoo.com/news/rss/world")

try {
	[xml]$Content = (invoke-webRequest -URI $RSS_URL).Content
	"`n🌍 $($Content.rss.channel.title) 🌏"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"→ $($item.title)"
		$Count++
		if ($Count -eq 26) { break }
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
