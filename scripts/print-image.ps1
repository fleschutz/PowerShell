<#
.SYNOPSIS
	Prints an image
.DESCRIPTION
	This PowerShell script shows the printer dialogue to print the given image file.
.PARAMETER Path
	Specifies the path to the image file
.EXAMPLE
	PS> ./print-image dog.jpg
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param($Path = "")

try {
	if ("$Path" -eq "") {
		$Path = Read-Host "Enter path to the image file"
	}
	Start-Process -filepath $Path -verb print
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
