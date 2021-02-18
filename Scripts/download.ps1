#!/bin/powershell
<#
.SYNTAX         ./download.ps1 [<URL>]
.DESCRIPTION	downloads the file/directory from the given URL
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($URL = "")

if ($URL -eq "" ) {
	$URL = read-host "Enter URL to download"
}

try {
	& wget --version
} catch {
	write-error "Can't execute 'wget' - make sure wget is installed and available"
	exit 1
}

try {
	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose

	write-host -foregroundColor green "Done."
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
