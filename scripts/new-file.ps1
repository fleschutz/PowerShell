<#
.SYNOPSIS
	Creates a new file 
.DESCRIPTION
	This PowerShell script creates a new file from a template.
.PARAMETER path
	Specifies the path and new filename ('NEW.txt' by default)
.EXAMPLE
	PS> ./new-file.ps1 
	✅ New 'NEW.txt' created in 0s (based on '.txt' template).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "NEW.txt")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$suffix = (Split-Path -Path $path -Leaf).Split(".")[1]

	$templateFile = "$PSScriptRoot/data/templates/new.$($suffix)" 
	if (-not(Test-Path "$templateFile" -pathType leaf)) { throw "No template file 'new.$($suffix)' yet - Please add one" }

	Copy-Item $templateFile "$path"

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ New '$path' created in $($elapsed)s (based on '.$suffix' template)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
