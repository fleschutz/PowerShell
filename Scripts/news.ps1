#!/snap/bin/powershell
#
# Syntax:       news.ps1
# Description:	print the latest news
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
Invoke-WebRequest -Uri 'https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml' -OutFile news.temp.xml

[xml]$FileContent = Get-Content news.temp.xml

foreach ($item in $FileContent.rss.channel.item) {
	write-output "+++"$item.title
}

remove-item news.temp.xml 

exit 0
