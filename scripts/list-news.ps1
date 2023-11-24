<#
.SYNOPSIS
	Lists the latest news
.DESCRIPTION
	This PowerShell script lists the latest news by using a RSS (Really Simple Syndication) feed.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo World News by default)
.PARAMETER maxLines
	Specifies the maximum number of lines to list (24 by default)
.PARAMETER speed
        Specifies the speed to write the text (10 ms by default)
.EXAMPLE
	PS> ./list-news.ps1
	❇️ Deadly Mediterranean wildfires kill more than 40
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://news.yahoo.com/rss/world", [int]$maxLines = 24, [int]$speed = 10)

try {
	[xml]$content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	[int]$count = 1
	foreach ($item in $content.rss.channel.item) {
		& "$PSScriptRoot/write-typewriter.ps1" "❇️ $($item.title)" $speed
		if ($count++ -eq $maxLines) { break }
	}
	$source = $content.rss.channel.title
	$date = $content.rss.channel.pubDate
	"   (by $source as of $date)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}