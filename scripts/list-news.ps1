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
  
	 UTC   HEADLINES         (source: https://www.yahoo.com/news/world)
	 ---   ---------
	09:15  Deadly Mediterranean wildfires kill more than 40
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://news.yahoo.com/rss/world", [int]$maxLines = 24, [int]$speed = 5)

try {
	[xml]$content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	$title = $content.rss.channel.title
	$URL = $content.rss.channel.link
	Write-Host "`n UTC   HEADLINES             (source: " -noNewline
        Write-Host $URL -foregroundColor blue -noNewline
        Write-Host ")"
        Write-Host " ---   ---------"
	[int]$count = 1
	foreach ($item in $content.rss.channel.item) {
		$title = $item.title -replace "â","'"
		$time = $item.pubDate.Substring(11, 5)
		& "$PSScriptRoot/write-typewriter.ps1" "$time  $title" $speed
		if ($count++ -eq $maxLines) { break }
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
