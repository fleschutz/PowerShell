<#
.SYNOPSIS
	Sets the working directory to the user's documents folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's documents folder.
.EXAMPLE
	PS> ./cd-docs
	📂/home/markus/Documents
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Documents"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Documents folder at 📂$TargetDir doesn't exist (yet)"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
