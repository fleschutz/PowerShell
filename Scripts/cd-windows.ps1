<#
.SYNOPSIS
	Sets the working directory to the Windows directory
.DESCRIPTION
	This PowerShell script changes the working directory to the Windows directory.
.EXAMPLE
	PS> ./cd-windows
	📂C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Path = resolve-path "$env:WINDIR"
	if (-not(test-path "$Path" -pathType container)) {
		throw "Windows directory at 📂$Path doesn't exist"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
