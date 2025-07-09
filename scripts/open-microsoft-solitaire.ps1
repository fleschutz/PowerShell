<#
.SYNOPSIS
	Launches Microsoft Solitaire 
.DESCRIPTION
	This script launches the Microsoft Solitaire application.
.EXAMPLE
	PS> ./open-microsoft-solitaire.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process xboxliveapp-1297287741:
exit 0 # success
