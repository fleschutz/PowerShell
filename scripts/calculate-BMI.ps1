<#
.SYNOPSIS
	Calculate the BMI
.DESCRIPTION
	This PowerShell script calculates the BMI.
.EXAMPLE
	PS> ./calculate-BMI.ps1
	Enter your height in m :
	..g
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	[float]$height = Read-Host("Enter your height in m ")
	[float]$weight = Read-Host("Enter your weight in kg")
	$BMI = $weight / ($height * $height)
	"Your BMI is $BMI, for adults the WHO regards:"
	" <16     as Underweight (severe thinness)"
	" 16-17   as Underweight (moderate thinness)"
	" 17-18.5 as Underweight (mild thinness)"
	" 18.5-25 as Normal range"
	" 25-30   as Overweight (pre-obese)"
	" 30-35   as Obese (class I)"
	" 35-40   as Obese (class II)"
	" >=40    as Obese (class III)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
