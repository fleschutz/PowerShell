<#
.SYNOPSIS
	Launches the 3D-Viewer app
.DESCRIPTION
	This script launches the 3D-Viewer application.
.EXAMPLE
	PS> ./open-three-d-viewer.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process com.microsoft.3dviewer:
exit 0 # success
