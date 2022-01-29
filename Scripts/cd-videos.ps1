<#
.SYNOPSIS
	Sets the working directory to the user's videos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's videos folder.
.EXAMPLE
	PS> ./cd-videos
	📂/home/markus/Videos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Videos"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Videos folder at 📂$TargetDir doesn't exist (yet)"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
