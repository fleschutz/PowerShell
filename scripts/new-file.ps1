<#
.SYNOPSIS
	Creates a new file 
.DESCRIPTION
	This PowerShell script creates a new file from a template.
.PARAMETER path
	Specifies the path and the new filename.
.EXAMPLE
	PS> ./new-file.ps1 my.txt
	✅ Created new 'my.txt' from .txt template in 0s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "") { $path = Read-Host "Enter the path and the new filename" }

	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$suffix = (Split-Path -Path $path -Leaf).Split(".")[1]

	$templateFile = "$PSScriptRoot/data/templates/new.$($suffix)" 
	if (-not(Test-Path "$templateFile" -pathType leaf)) { throw "No template file 'new.$($suffix)' yet - Please add one" }

	Copy-Item $templateFile "$path"

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Created new '$path' from .$suffix template in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
