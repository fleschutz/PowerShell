<#
.SYNOPSIS
	Counts the lines of code (LOC)
.DESCRIPTION
	This PowerShell script counts the number of code lines in a folder (including subfolders).
.PARAMETER path
	Specifies the path to the folder
.EXAMPLE
	PS> ./count-lines-of-code.ps1 .
	✔️ Counted 19609 lines of code (LOC) in 577 files in 📂Scripts (took 1 sec)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $Folder = Read-Host "Enter the path to the folder" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$path = Resolve-Path "$path"

	Write-Progress "⏳ Counting lines of code in 📂$path ..."
	[int]$Files = [int]$CodeLines = 0
	Get-ChildItem -Path $path -Include *.c,*.h,*.cpp,*.hpp,*.java,*.ps1 -Recurse | ForEach-Object {
		$FileStats = Get-Content $_.FullName | Measure-Object -line
		$CodeLines += $FileStats.Lines
		$Files++
	}
	Write-Progress -completed "."

	$FolderName = (Get-Item "$path").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Counted $CodeLines lines of code (LOC) in $Files files in 📂$FolderName (took $Elapsed sec)" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}