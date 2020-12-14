#!/snap/bin/powershell

# Syntax:       ./download.ps1 [<URL>]
# Description:	downloads the file/directory from the given URL
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$URL)

try {
	if ($URL -eq "" ) {
		$URL = read-host "Enter URL to download"
	}

	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	Write-Output "OK."
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
