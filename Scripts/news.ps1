#!/snap/bin/powershell
#
# Syntax:       ./news.ps1
# Description:	print the latest news
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
#$RSS_URL = "http://feeds.skynews.com/feeds/rss/world.xml"
$RSS_URL = "https://yahoo.com/news/rss/world"
# $RSS_URL = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"

[xml]$FileContent = (Invoke-WebRequest -Uri $RSS_URL).Content

write-host ""
write-host "+++ " $FileContent.rss.channel.title " +++"
write-host ""

foreach ($item in $FileContent.rss.channel.item) {
	write-host "* "$item.title
}
exit 0
