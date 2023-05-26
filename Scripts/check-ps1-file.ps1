<#
.SYNOPSIS
	Checks a PowerShell file for validity
.DESCRIPTION
	This PowerShell script checks the given PowerShell file for validity.
.PARAMETER pattern
	Specifies the file pattern to the PowerShell file(s) to check
.EXAMPLE
	PS> ./check-ps1-file *.ps1
	✔️ Valid PowerShell in myfile.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pattern = "")

try {
	if ($pattern -eq "" ) { $path = Read-Host "Enter the file pattern to the PowerShell file(s)" }
	$files = Get-ChildItem $pattern
	foreach ($file in $files) {
		$syntaxError = @()
		[void][System.Management.Automation.Language.Parser]::ParseFile($file, [ref]$null, [ref]$syntaxError)
		if ("$syntaxError" -ne "") { throw "$syntaxError" }
		"✔️ Valid PowerShell in $file"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
