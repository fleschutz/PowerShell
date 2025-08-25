<#
.SYNOPSIS
	Checks PowerShell file(s) for validity
.DESCRIPTION
	This PowerShell script checks the given PowerShell script file(s) for validity.
.PARAMETER filePattern
	Specifies the file pattern to the PowerShell file(s)
.EXAMPLE
	PS> ./check-ps1-file *.ps1
	✅ Valid PowerShell in myfile.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filePattern = "")

try {
	if ($filePattern -eq "" ) { $path = Read-Host "Enter the file pattern to the PowerShell file(s)" }

	$files = Get-ChildItem -path "$filePattern" -attributes !Directory
	foreach ($file in $files) {
		$syntaxError = @()
		[void][System.Management.Automation.Language.Parser]::ParseFile($file, [ref]$null, [ref]$syntaxError)
		if ("$syntaxError" -ne "") { throw "$syntaxError" }
		"✅ Valid PowerShell in $($file.Name)"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
