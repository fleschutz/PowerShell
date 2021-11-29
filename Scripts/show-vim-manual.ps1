<#
.SYNOPSIS
	Shows the Vim manual
.DESCRIPTION
	This script launches the Web browser with the Vim manual.
.EXAMPLE
	PS> ./show-vim-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.vim.org/docs.php"
exit 0 # success
