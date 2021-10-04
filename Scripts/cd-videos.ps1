<#
.SYNOPSIS
	Change the working directory to the user's videos folder
.DESCRIPTION
	cd-videos.ps1 
.EXAMPLE
	PS> ./cd-videos
	📂/home/markus/Videos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Videos"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's videos folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
