<#
.SYNOPSIS
	Lists the latest news
.DESCRIPTION
	This PowerShell script lists the latest RSS feed news.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed
.PARAMETER MaxCount
	Specifies the number of lines to list (20 by default)
.EXAMPLE
	PS> ./list-news
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 20)

try {
	[xml]$Content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	[int]$Count = 1
	foreach ($item in $Content.rss.channel.item) {
		"→ $($item.title)"
		if ($Count++ -eq $MaxCount) { break }
	}
	"  Source: 🌍 $($Content.rss.channel.title) 🌍"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
