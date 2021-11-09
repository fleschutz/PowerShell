<#
.SYNOPSIS
	Closes the Paint 3D app 
.DESCRIPTION
	This script closes the Paint 3D application gracefully.
.EXAMPLE
	PS> ./close-paint-3d
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im Paint3D
exit 0 # success
