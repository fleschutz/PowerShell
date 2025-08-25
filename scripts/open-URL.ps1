<#
.SYNOPSIS
	Opens an URL in the default browser
.DESCRIPTION
	This PowerShell script launches a new tab in the default Web browser with the given URL.
.PARAMETER URL
	Specifies the URL
.PARAMETER text
	Specifies the text to write to the console
.EXAMPLE
	PS> ./open-URL.ps1 https://cnn.com
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$URL = "", [string]$text = "")

try {
	if ($URL -eq "") { $URL = Read-Host "Enter the URL" }

	if ($IsLinux -or $IsMacOS) {
		Write-Host $text -noNewline
		Write-Host $URL -foregroundColor blue -noNewline
		Write-Host " (open link with: <Ctrl> <click>)"
	} else {
		Start-Process $URL
		Write-Host "✅ Launched Web browser with $text" -noNewline
		Write-Host $URL -foregroundColor blue
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
