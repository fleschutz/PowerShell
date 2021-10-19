<#
.SYNOPSIS
	Sets the working directory to the user's autostart folder
.DESCRIPTION
	This script changes the working directory to the user's autostart folder.
.EXAMPLE
	PS> ./cd-autostart
	📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's autostart folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
