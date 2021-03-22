#!/bin/powershell
<#
.SYNTAX       ./list-random-pins.ps1 [<pin-length>] [<columns>] [<rows>]
.DESCRIPTION  prints a list of random PIN's
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param([int]$PinLength = 5, [int]$Columns = 12, [int]$Rows = 24)

function GeneratePIN {
	$Generator = New-Object System.Random
	for ($i = 0; $i -lt $PinLength; $i++) {
		$PIN += [char]$Generator.next(48,57)
	}
	return $PIN
}

try {
	write-output ""
	for ($j = 0; $j -lt $Rows; $j++) {
		$Line = ""
		for ($k = 0; $k -lt $Columns; $k++) {
			$Line += GeneratePIN
			$Line += "   "
		}
		write-output $Line
	}
	write-output ""
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
