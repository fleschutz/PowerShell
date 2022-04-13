<#
.SYNOPSIS
	Sets the working directory to three directory levels up
.DESCRIPTION
	This PowerShell script changes the working directory to three directory levels up.
.EXAMPLE
	PS> ./cd-up3
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Path = resolve-path "../../.."
	if (-not(test-path "$Path" -pathType container)) {
		throw "Folder at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
