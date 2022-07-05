<#
.SYNOPSIS
	Sets the working directory to the temporary folder
.DESCRIPTION
	This PowerShell script changes the working directory to the temporary folder.
.EXAMPLE
	PS> ./cd-temp
	📂C:\Users\Markus\AppData\Local\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
        if ($IsLinux) { return "/tmp" }
        return "C:\Temp"
}

try {
	$Path = GetTempDir
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Temporary folder at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
