<#
.SYNOPSIS
	Lists the latest headlines
.DESCRIPTION
	This PowerShell script lists the latest RSS feed news.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed
.PARAMETER MaxCount
	Specifies the number of news to list
.EXAMPLE
	PS> ./list-headlines.ps1
	❇️ Niger coup: Ecowas deadline sparks anxiety in northern Nigeria
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 20)

try {
	[xml]$Content = (Invoke-WebRequest -uri $RSS_URL -useBasicParsing).Content
	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"❇ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
        $Source = $Content.rss.channel.title
        $Date = $Content.rss.channel.pubDate
	"(by $Source as of $Date)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
