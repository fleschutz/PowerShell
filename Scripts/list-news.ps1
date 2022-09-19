<#
.SYNOPSIS
	Lists the news
.DESCRIPTION
	This PowerShell script lists the latest news by using RSS (Really Simple Syndication) feeds.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo News by default)
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
	foreach ($Item in $Content.rss.channel.item) {
		"→ $($Item.title)"
		if ($Count++ -eq $MaxCount) { break }
	}
	$Source = $Content.rss.channel.title
	$Date = $Content.rss.channel.pubDate
	"  Source: $Source (as of $Date)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}