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
	Specifies the time interval in seconds between two Web requests (60 seconds by default)
.EXAMPLE
	PS> ./watch-news.ps1

	 UTC   HEADLINES           (source: https://www.yahoo.com/news/world)
	 ---   ---------
	14:29  Niger coup: Ecowas deadline sparks anxiety in northern Nigeria
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$URL = "https://news.yahoo.com/rss/world", [int]$timeInterval = 60) # in seconds

function PrintLatestHeadlines([xml]$content, [string]$latestTimestamp, [string]$icon) {
	$items = $content.rss.channel.item
	[array]::Reverse($items)
	$newLatest = $latestTimestamp
	foreach($item in $items) {
		$pubDate = $item.pubDate
		if ($pubDate -le $latestTimestamp) { continue }
		$title = $item.title -replace "â","'"
		$time = $pubDate.Substring(11, 5)
		Write-Host "$time  $title$icon"
		Start-Sleep -milliseconds 500
		if ($pubDate -gt $newLatest) { $newLatest = $pubDate }
	}
	return $newLatest
}

try {
	[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	$title = $content.rss.channel.title.toUpper()
	$link = $content.rss.channel.link
	Write-Host "`n UTC   HEADLINES                 (source: " -noNewline
	Write-Host $link -foregroundColor blue -noNewline
	Write-Host ")"
	Write-Host " ---   ---------"
	$latestTimestamp = "2000-01-01"
	$icon = ""
	do {
		$latestTimestamp = PrintLatestHeadlines $content $latestTimestamp $icon
		$icon = "🆕"
		Start-Sleep -seconds $timeInterval
		[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
