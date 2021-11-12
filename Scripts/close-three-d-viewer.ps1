<#
.SYNOPSIS
	Closes the 3D Viewer app 
.DESCRIPTION
	This script closes the 3D Viewer application gracefully.
.EXAMPLE
	PS> ./close-three-d-viewer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /f /im 3DViewer.exe
exit 0 # success
