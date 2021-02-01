#!/snap/bin/powershell
<#
.SYNTAX         ./download.ps1 [<URL>]
.DESCRIPTION	downloads the file/directory from the given URL
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$URL = "")

try {
	if ($URL -eq "" ) {
		$URL = read-host "Enter URL to download"
	}

	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	write-output "OK."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
