#!/snap/bin/powershell

# Syntax:       ./download.ps1 [<URL>]
# Description:	downloads the file/directory from the given URL
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$URL)
if ($URL -eq "" ) {
	$URL = read-host "Enter URL to download"
}

try {
	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	write-host "✔️ Done."
	exit 0
} catch { Write-Error $Error[0] }
exit 1
