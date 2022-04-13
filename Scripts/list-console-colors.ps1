<#
.SYNOPSIS
	Lists all console colors
.DESCRIPTION
	This PowerShell script lists all available console colors.
.EXAMPLE
	PS> ./list-console-colors

	Color     As Foreground     As Background
	-----     -------------     -------------
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Colors = [Enum]::GetValues([ConsoleColor])
	""
	"Color          As Foreground  As Background"
	"-----          -------------  -------------"
	foreach($Color in $Colors) {
		$Color = "$Color              "
		$Color = $Color.substring(0, 15)
		write-host -noNewline "$Color"
		write-host -noNewline -foregroundcolor $Color "$Color"
		write-host -noNewline -backgroundcolor $Color "$Color"
		write-host ""
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
