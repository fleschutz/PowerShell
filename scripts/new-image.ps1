<#
.SYNOPSIS
	Create an image
.DESCRIPTION
	This script launches the Web browser with texttoimage.org to create a new image.
.EXAMPLE
	PS> ./new-image.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-URL.ps1" "https://www.texttoimage.org" "Text to Image: "
exit 0 # success
