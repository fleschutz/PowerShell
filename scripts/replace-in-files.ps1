<#
.SYNOPSIS
	Search and replace a pattern in the given files by the replacement
.DESCRIPTION
	This PowerShell script searches and replaces a pattern in the given files by the replacement.
.PARAMETER pattern
	Specifies the text pattern to search for (ask user by default)
.PARAMETER replacement
	Specifies the text replacement (ask user by default)
.PARAMETER filePattern
	Specifies the file search pattern (ask user by default)
.EXAMPLE
	PS> ./replace-in-files NSA "No Such Agency" C:\Temp\*.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pattern = "", [string]$replacement = "", [string]$filePattern = "")

function ReplaceInFile([string]$path, [string]$pattern, [string]$replacement) {
    [System.IO.File]::WriteAllText($path,
        ([System.IO.File]::ReadAllText($path) -replace $pattern, $replacement)
    )
}

try {
	if ($pattern -eq "" ) {         $pattern = Read-Host "Enter the text to search for, e.g. 'Joe' " }
	if ($replacement -eq "" ) { $replacement = Read-Host "Enter the text to replace with, e.g. 'J' " }
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file search pattern, e.g. '*.c'" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$files = (Get-ChildItem -path "$filePattern" -attributes !Directory)
	foreach($file in $files) {
		ReplaceInFile $file $pattern $replacement
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Replaced '$pattern' by '$replacement' in $($files.Count) files in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
