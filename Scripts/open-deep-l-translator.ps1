<#
.SYNOPSIS
	Opens the DeepL Translator website 
.DESCRIPTION
	This script launches the Web browser with the DeepL Translator website.
.EXAMPLE
	PS> ./open-deep-l-translator
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.deepl.com/translator"
exit 0 # success
