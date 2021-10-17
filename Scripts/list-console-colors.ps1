<#
.SYNOPSIS
	Lists all console colors
.DESCRIPTION
	This script lists all available console colors.
.EXAMPLE
	PS> ./list-console-colors

	Color     As Foreground     As Background
	-----     -------------     -------------
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
