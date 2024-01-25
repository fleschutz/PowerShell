<#
.SYNOPSIS
	Checks all XML files in a directory tree
.DESCRIPTION
	This PowerShell script verifies each XML file (with suffix .xml) in the given directory tree for validity.
.PARAMETER path
	Specifies the path to the directory tree (current working dir by default)
.EXAMPLE
	PS> ./check-xml-files.ps1 C:\Windows
	...
	✔️ Checked 3387 XML files within 📂C:\Windows in 174 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
 	[int]$numXmlFiles = 0

	Write-Progress "Scanning all XML files within $path..."
	Get-ChildItem -path "$path" -attributes !Directory -recurse -force | Where-Object { $_.Name -like "*.xml" } | Foreach-Object {
		& $PSScriptRoot/check-xml-file.ps1 "$($_.FullName)"
                $numXmlFiles++
        }
	Write-Progress -completed "Done."

        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
        "✔️ Checked $numXmlFiles XML files within 📂$path in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
