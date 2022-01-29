<#
.SYNOPSIS
	Sets the working directory to the temporary folder
.DESCRIPTION
	This PowerShell script changes the working directory to the temporary folder.
.EXAMPLE
	PS> ./cd-temp
	📂C:\Users\markus\AppData\Local\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function GetTempDir {
	if ($IsLinux) { return "/tmp" }
	return "$env:TEMP"
}

try {
	$TargetDir = resolve-path GetTempDir
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Temporary folder at 📂$TargetDir doesn't exist (yet)"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
