﻿<#
.SYNOPSIS
	Launches Screen Clip
.DESCRIPTION
	This script launches the Screen Clip application.
.EXAMPLE
	PS> ./open-screen-clip.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start-Process ms-screenclip:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
