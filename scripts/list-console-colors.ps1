<#
.SYNOPSIS
	Lists all console colors
.DESCRIPTION
	This PowerShell script lists all available console colors.
.EXAMPLE
	PS> ./list-console-colors.ps1

	Color     As Foreground     As Background
	-----     -------------     -------------
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$colors = [Enum]::GetValues([ConsoleColor])
	""
	"COLOR          FOREGROUND     BACKGROUND"
	"-----          ----------     ----------"
	foreach($color in $colors) {
		$color = "$color              "
		$color = $color.substring(0, 15)
		Write-Host "$color" -noNewline
		Write-Host "$color" -foregroundColor $color -noNewline
		Write-Host "$color" -backgroundColor $color
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
