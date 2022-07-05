<#
.SYNOPSIS
	Launches the 3D-Viewer app
.DESCRIPTION
	This script launches the 3D-Viewer application.
.EXAMPLE
	PS> ./open-three-d-viewer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process com.microsoft.3dviewer:
exit 0 # success
