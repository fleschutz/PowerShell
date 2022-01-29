<#
.SYNOPSIS
	Sets the working directory to the user's home directory
.DESCRIPTION
	This PowerShell script changes the working directory to the user's home directory.
.EXAMPLE
	PS> ./cd-home
	📂/home/markus
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Home directory at 📂$TargetDir doesn't exist (yet)"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
