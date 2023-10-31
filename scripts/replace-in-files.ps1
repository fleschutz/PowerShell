<#
.SYNOPSIS
	Search and replace a pattern in the given files by the replacement
.DESCRIPTION
	This PowerShell script searches and replaces a pattern in the given files by the replacement.
.PARAMETER pattern
	Specifies the text pattern to look for
.PARAMETER replacement
	Specifies the text replacement
.PARAMETER filePattern
	Specifies the file to scan
.EXAMPLE
	PS> ./replace-in-files NSA "No Such Agency" C:\Temp\*.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pattern = "", [string]$replacement = "", [string]$filePattern = "")

function ReplaceInFile { param([string]$path, [string]$pattern, [string]$replacement)

    [System.IO.File]::WriteAllText($path,
        ([System.IO.File]::ReadAllText($path) -replace $pattern, $replacement)
    )
}

try {
	if ($pattern -eq "" ) { $pattern = Read-Host "Enter the text pattern to look for" }
	if ($replacement -eq "" ) { $replacement = Read-Host "Enter the text replacement" }
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file pattern" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$files = (Get-ChildItem -path "$filePattern" -attributes !Directory)
	foreach($file in $files) {
		ReplaceInFile $file $pattern $replacement
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Replaced '$pattern' by '$replacement' in $($files.Count) files in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
