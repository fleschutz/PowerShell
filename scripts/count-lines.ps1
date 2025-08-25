<#
.SYNOPSIS
	Counts the number of lines 
.DESCRIPTION
	This PowerShell script counts the number of lines in text files (.txt/.md/.c/.h/.cpp/.hpp/.java/.py/.ps1/.bat) within a directory tree.
.PARAMETER pathToDirTree
	Specifies the path to the directory tree.
.EXAMPLE
	PS> ./count-lines.ps1 C:\Repos\cmake
	✅ Found 639921 lines in 11411 text files within 📂cmake in 34 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToDirTree = "")

try {
	if ($pathToDirTree -eq "" ) { $pathToDirTree = Read-Host "Enter the path to the directory tree" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$pathToDirTree = Resolve-Path "$pathToDirTree"
	Write-Progress "Counting lines within $pathToDirTree ..."

	[int64]$numFiles = [int64]$numLines = 0
	Get-ChildItem -Path $pathToDirTree -Include *.txt,*.md,*.c,*.h,*.cpp,*.hpp,*.java,*.py,*.ps1,*.bat -Recurse | ForEach-Object {
		$numLines += (Get-Content $_.FullName | Measure-Object -line).Lines
		$numFiles++
	}

	$folderName = (Get-Item "$pathToDirTree").Name
	Write-Progress -completed " "
	[int]$Elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $numLines lines in $numFiles text files within 📂$folderName in $Elapsed sec." 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
