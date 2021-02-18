#!/bin/powershell
<#
.SYNTAX         ./list-news.ps1 [<RSS-URL>]
.DESCRIPTION	lists the latest news
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RSS_URL = "https://yahoo.com/news/rss/world")

try {
	[xml]$Content = (invoke-webRequest -URI $RSS_URL).Content

	write-output ""
	write-output "+++ $($Content.rss.channel.title) +++"
	write-output ""

	foreach ($item in $Content.rss.channel.item) {
		write-output "* $($item.title)"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
