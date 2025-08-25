﻿<#
.SYNOPSIS
	Lists random passwords
.DESCRIPTION
	This PowerShell script lists random passwords.
.PARAMETER PasswordLength
	Specifies the length of the password
.PARAMETER Columns
	Specifies the number of columns
.PARAMETER Rows
	Specifies the number of rows
.EXAMPLE
	PS> ./list-passwords.ps1

	"4yE=[mu"Az|IE@   PZ}E9Q"&?.!%49`   zU3[E7`xA)(6W_3   :wd'a(O@fr}.Z8=
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$PasswordLength = 15, [int]$Columns = 6, [int]$Rows = 30)

$MinCharCode = 33
$MaxCharCode = 126

try {
	write-output ""
	$Generator = New-Object System.Random
	for ($j = 0; $j -lt $Rows; $j++) {
		$Line = ""
		for ($k = 0; $k -lt $Columns; $k++) {
			for ($i = 0; $i -lt $PasswordLength; $i++) {
				$Line += [char]$Generator.next($MinCharCode,$MaxCharCode)
			}
			$Line += "   "
		}
		write-output "$Line"
	}
	write-output ""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
