﻿<#
.SYNOPSIS
	Launches the Microsoft Outlook app
.DESCRIPTION
	This script launches the Microsoft Outlook email application.
.EXAMPLE
	PS> ./open-outlook.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function TryToExec { param($Folder, $Binary)
        if (test-path "$Folder/$Binary" -pathType leaf) {
                start-process "$Folder/$Binary" -WorkingDirectory "$Folder"
                exit 0 # success
        }
}

try {
	TryToExec "C:\Program Files\Microsoft Office\root\Office16" "OUTLOOK.EXE"
	TryToExec "C:\Programs\Microsoft Office\Office14" "OUTLOOK.EXE"
	throw "It seems Outlook isn't installed yet."
} catch {
	& "$PSScriptRoot/speak-english.ps1" "Sorry: $($Error[0])"
	exit 1
}
