<#
.SYNOPSIS
	list-news.ps1 [<RSS-URL>] [<max-count>]
.DESCRIPTION
	Lists the latest news
.EXAMPLE
	PS> ./list-news
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 20)

try {
	[xml]$Content = (invoke-webRequest -uri $RSS_URL -useBasicParsing).Content
	"`n🌍 $($Content.rss.channel.title) 🌏"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"→ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
