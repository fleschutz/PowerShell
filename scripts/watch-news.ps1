<#
.SYNOPSIS
	Watch the latest headlines
.DESCRIPTION
	This PowerShell script lists the latest headlines by using a RSS (Really Simple Syndication) feed.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo World News by default)
.EXAMPLE
	PS> ./watch-headlines.ps1
	             ❇️ Niger coup: Ecowas deadline sparks anxiety in northern Nigeria ❇️
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://news.yahoo.com/rss/world", [int]$timeInterval = 30000) # in ms

function GetLatestHeadline {
	[xml]$content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	foreach ($item in $content.rss.channel.item) { return "$($item.title)" }
	return ""
}

try {
	$previous = ""
	while ($true) {
		$latest = GetLatestHeadline
		if ($latest -ne $previous) {
			& "$PSScriptRoot/write-animated.ps1" "❇️ $latest ❇️"
			$previous = $latest
		}
		Start-Sleep -milliseconds $timeInterval
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
