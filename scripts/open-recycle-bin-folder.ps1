﻿<#
.SYNOPSIS
	Opens the recycle bin folder
.DESCRIPTION
	This script launches the File Explorer with the user's recycle bin folder.
.EXAMPLE
	PS> ./open-recycle-bin-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start shell:recyclebinfolder
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
