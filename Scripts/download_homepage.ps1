#!/snap/bin/powershell
#
# Syntax:       ./download_homepage.ps1 
# Description:	downloads from the given URL
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

backup()
{
	URL=$1
	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
}

backup $1
exit 0
