<#
.SYNOPSIS
	Sets the working directory to the root directory 
.DESCRIPTION
	This PowerShell script changes the working directory to the root directory (C:\ on Windows).
.EXAMPLE
	PS> ./cd-root
	📂C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$Path = resolve-path "/"
	} else {
		$Path = resolve-path "C:\"
	}
	if (-not(test-path "$Path" -pathType container)) {
		throw "Root directory at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
