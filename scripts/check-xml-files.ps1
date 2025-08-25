<#
.SYNOPSIS
	Checks all XML files in a directory tree
.DESCRIPTION
	This PowerShell script verifies any XML file (with suffix .xml) in the given directory tree for validity.
.PARAMETER path
	Specifies the file path to the directory tree (current working dir by default)
.EXAMPLE
	PS> ./check-xml-files.ps1 C:\Windows
	...
	✅ Checked 3387 XML files (2462 invalid, 925 valid) within 📂C:\Windows in 116 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$path = Resolve-Path "$path"
 	[int]$valid = [int]$invalid = 0

	Get-ChildItem -path "$path" -attributes !Directory -recurse -force | Where-Object { $_.Name -like "*.xml" } | Foreach-Object {
		& $PSScriptRoot/check-xml-file.ps1 "$($_.FullName)"
		if ($lastExitCode -eq 0) { $valid++ } else { $invalid++ }
        }

        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	if ($invalid -ne 0) {
        	"⚠️ $invalid XML files are INVALID, $valid are valid (took $($elapsed)s)."
	} else {
		"✅ All $valid XML files are valid (took $($elapsed)s)."
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
