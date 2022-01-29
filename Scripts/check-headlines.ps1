<#
.SYNOPSIS
	Checks the latests headlines
.DESCRIPTION
	This script tells the latest headlines by text-to-speech (TTS).
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed
.PARAMETER MaxCount
	Specifies the number of news to list
.EXAMPLE
	PS> ./check-headlines
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 8)

try {
	[xml]$Content = (invoke-webRequest -uri $RSS_URL -useBasicParsing).Content
	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		& "$PSScriptRoot/give-reply.ps1" "$($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
