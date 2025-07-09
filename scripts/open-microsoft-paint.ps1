﻿<#
.SYNOPSIS
	Launches the Microsoft Paint app
.DESCRIPTION
	This script launches the Microsoft Paint application.
.EXAMPLE
	PS> ./open-microsoft-paint.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	start-process mspaint.exe
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
