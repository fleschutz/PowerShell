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

param([string]$URL = "https://news.yahoo.com/rss/world", [int]$lines = 10, [int]$timeInterval = 30) # in seconds

function PrintLatestHeadlines([string]$previous, [int]$maxLines) {
	[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content
	[string]$latest = ""

	foreach ($item in $content.rss.channel.item) {
		$title = $item.title
		if ($latest -eq "") { $latest = $title }
		if ($title -eq $previous) { break }
		$time = $item.pubDate.Substring(11, 5)
		& "$PSScriptRoot/write-typewriter.ps1" "❇️ $time $title" 10
		$maxLines--
		if ($maxLines -eq 0) { break }
	}
	return $latest
}

try {
	[xml]$content = (Invoke-WebRequest -URI $URL -useBasicParsing).Content

	$title = $content.rss.channel.title
	$URL = $content.rss.channel.link
	" "
	"   UTC   $title - $URL"
	"   ---   -----------------------------------------------------------------------"
	$latest = ""
	do {
		$latest = PrintLatestHeadlines $latest $lines
		Start-Sleep -seconds $timeInterval
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
