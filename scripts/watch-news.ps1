<#
.SYNOPSIS
	Watch the news
.DESCRIPTION
	This PowerShell script continuously lists the latest headlines by using a RSS (Really Simple Syndication) feed.
.PARAMETER URL
	Specifies the URL to the RSS feed (default: https://news.yahoo.com/rss/world)
.PARAMETER updateInterval
	Specifies the update interval in seconds (default: 60 seconds)
.EXAMPLE
	PS> ./watch-news.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$URL = "https://news.yahoo.com/rss/world", [int]$updateInterval = 60, [int]$speed = 10)

function PrintNewerHeadlines([xml]$content, [string]$latestTimestamp, [string]$icon) {
	$items = $content.rss.channel.item
	[array]::Reverse($items)
	$newLatest = $latestTimestamp
	foreach($item in $items) {
		$pubDate = $item.pubDate
		if ($pubDate -le $latestTimestamp) { continue }
		$title = $item.title -replace "â","'"
		$time = $pubDate.Substring(11, 5)
		& "$PSScriptRoot/write-animated.ps1" "$title ($time)$icon" $speed
		if ($pubDate -gt $newLatest) { $newLatest = $pubDate }
	}
	return $newLatest
}

try {
	[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	$webLink = $content.rss.channel.link
	& "$PSScriptRoot/write-animated.ps1" "Source: $webLink" $speed
	& "$PSScriptRoot/write-animated.ps1" "-----------------------------" $speed
	$latestTimestamp = "2000-01-01"
	$icon = ""
	do {
		$latestTimestamp = PrintNewerHeadlines $content $latestTimestamp $icon
		Start-Sleep -seconds $updateInterval
		[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
		$icon = "🆕"
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
