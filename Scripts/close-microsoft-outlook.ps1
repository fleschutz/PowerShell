<#
.SYNOPSIS
	Closes Microsoft Outlook 
.DESCRIPTION
	This script closes the Microsoft Outlook email application gracefully.
.EXAMPLE
	PS> ./close-microsoft-outlook
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im outlook.exe
exit 0 # success
