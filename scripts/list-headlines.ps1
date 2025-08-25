<#
.SYNOPSIS
	Lists the latest headlines
.DESCRIPTION
	This PowerShell script lists the latest headlines by using a RSS (Really Simple Syndication) feed.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo World News by default)
.PARAMETER maxLines
	Specifies the maximum number of lines to list (24 by default)
.EXAMPLE
	PS> ./list-headlines.ps1
	❇️ Niger coup: Ecowas deadline sparks anxiety in northern Nigeria
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://news.yahoo.com/rss/world", [int]$maxLines = 24)

try {
	[xml]$content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	[int]$count = 1
	foreach ($item in $content.rss.channel.item) {
		"❇️ $($item.title)"
		if ($count++ -eq $maxLines) { break }
	}
        $source = $content.rss.channel.title
        $date = $content.rss.channel.pubDate
	"   (by $source as of $date)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
