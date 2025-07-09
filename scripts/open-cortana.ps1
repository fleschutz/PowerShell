﻿<#
.SYNOPSIS
	Launches the Cortana app
.DESCRIPTION
	This PowerShell script launches the Cortana application.
.EXAMPLE
	PS> ./open-cortana
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start-Process ms-cortana2:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
