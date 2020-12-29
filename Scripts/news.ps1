#!/snap/bin/powershell
<#
.SYNTAX         ./news.ps1
.DESCRIPTION	print the latest news
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

#$RSS_URL = "http://feeds.skynews.com/feeds/rss/world.xml"
$RSS_URL = "https://yahoo.com/news/rss/world"
# $RSS_URL = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"

try {
	[xml]$FileContent = (Invoke-WebRequest -Uri $RSS_URL).Content

	write-output ""
	write-output "+++ $($FileContent.rss.channel.title) +++"
	write-output ""

	foreach ($item in $FileContent.rss.channel.item) {
		write-output "* $($item.title)"
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
