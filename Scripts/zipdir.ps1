#!/snap/bin/powershell
#
# Syntax:       zipdir <path-to-folder>
# Description:	creates a zip archive of the given folder
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
param([string]$Path)
Compress-Archive -Path $Path -DestinationPath $Path.zip
exit 0
