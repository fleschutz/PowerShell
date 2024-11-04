<#
.SYNOPSIS
	Watch the news
.DESCRIPTION
	This PowerShell script continuously lists the latest headlines by using a RSS (Really Simple Syndication) feed.
.PARAMETER URL
	Specifies the URL to the RSS feed (Yahoo World News by default)
.PARAMETER lines
	Specifies the initial number of headlines
.PARAMETER timeInterval
	Specifies the time interval in seconds between two Web requests (30 seconds by default)
.EXAMPLE
	PS> ./watch-news.ps1

	   UTC   Yahoo News - Latest News & Headlines - https://www.yahoo.com/news/world
	   ---   -----------------------------------------------------------------------
	❇️ 14:29 Niger coup: Ecowas deadline sparks anxiety in northern Nigeria
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$URL = "https://news.yahoo.com/rss/world", [int]$timeInterval = 30) # in seconds

function PrintLatestHeadlines([xml]$content, [string]$latestTimestamp) {
	$items = $content.rss.channel.item
	[array]::Reverse($items)
	foreach($item in $items) {
		if ($($item.pubDate) -le $latestTimestamp) { continue }
		$title = $item.title
		$time = $item.pubDate.Substring(11, 5)
		& "$PSScriptRoot/write-typewriter.ps1" "❇️ $time $title" 2
		$latestTimestamp = $item.pubDate
	}
	return $latestTimestamp
}

try {
	[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	$title = $content.rss.channel.title
	$link = $content.rss.channel.link
	" "
	"   UTC   $title - $link"
	"   ---   -----------------------------------------------------------------------"
	$latestTimestamp = "2000-01-01"
	do {
		$latestTimestamp = PrintLatestHeadlines $content $latestTimestamp
		Start-Sleep -seconds $timeInterval
		[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
