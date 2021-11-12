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

taskkill /f /im PaintStudio.View.exe
exit 0 # success
