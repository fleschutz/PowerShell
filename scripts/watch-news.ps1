<#
.SYNOPSIS
	Watch the latest headlines
.DESCRIPTION
	This PowerShell script lists the latest headlines by using a RSS (Really Simple Syndication) feed.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo World News by default)
.PARAMETER timeInterval
	Specifies the time interval in millisec between the Web requests
.EXAMPLE
	PS> ./watch-news.ps1
	❇️ Niger coup: Ecowas deadline sparks anxiety in northern Nigeria ❇️
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://news.yahoo.com/rss/world", [int]$timeInterval = 30000) # in ms

function PrintLatestHeadlines([string]$previous, [int]$maxLines) {
	[xml]$content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	[string]$latest = ""

	foreach ($item in $content.rss.channel.item) {
		$itemTitle = "$($item.title)"
		if ($latest -eq "") { $latest = $itemTitle }
		if ($itemTitle -eq $previous) { break }

		& "$PSScriptRoot/write-animated.ps1" "❇️ $itemTitle ❇️"
		$maxLines--
		if ($maxLines -eq 0) { break }
	}
	return $latest
}

try {
	$latest = ""
	while ($true) {
		$latest = PrintLatestHeadlines $latest 10
		Start-Sleep -milliseconds $timeInterval
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
