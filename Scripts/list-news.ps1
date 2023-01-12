<#
.SYNOPSIS
	List news
.DESCRIPTION
	This PowerShell script lists the latest news by using RSS (Really Simple Syndication) feeds.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed (Yahoo News by default)
.PARAMETER MaxLines
	Specifies the maximum number of lines to list (24 by default)
.PARAMETER Speed
        Specifies the speed to write the text (10 ms by default)
.EXAMPLE
	PS> ./list-news
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxLines = 24, [int]$Speed = 10)

try {
	[xml]$Content = (Invoke-WebRequest -URI $RSS_URL -useBasicParsing).Content
	[int]$Count = 1
	foreach ($Item in $Content.rss.channel.item) {
		& "$PSScriptRoot/write-typewriter.ps1" "❇️ $($Item.title)" $Speed
		if ($Count++ -eq $MaxLines) { break }
	}
	$Source = $Content.rss.channel.title
	$Date = $Content.rss.channel.pubDate
	$Date = $Date -Replace "Mon, ",""
	$Date = $Date -Replace "Tue, ",""
	$Date = $Date -Replace "Wed, ",""
	$Date = $Date -Replace "Thu, ",""
	$Date = $Date -Replace "Fri, ",""
	$Date = $Date -Replace "Sat, ",""
	$Date = $Date -Replace "Sun, ",""
	$Copyright = $Content.rss.channel.copyright
	"($Source|$Date|$Copyright)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}