<#
.SYNOPSIS
	Counts lines of code
.DESCRIPTION
	This PowerShell script counts the number of code lines in a folder (including subfolders).
.PARAMETER Folder
	Specifies the path to the folder
.EXAMPLE
	PS> ./count-lines-of-code .
	⏳ Counting lines at 📂C:\PowerShell\Scripts ...
	✔️ 📂Scripts contains 15287 lines of code in 485 files (took 1 sec)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Folder = "")

try {
	if ($Folder -eq "" ) { $Folder = read-host "Enter the path to the folder" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$Folder = Resolve-Path "$Folder"
	"⏳ Counting lines at 📂$Folder ..."

	[int]$Files = [int]$CodeLines = 0
	Get-ChildItem -Path $Folder -Include *.c,*.h,*.cpp,*.hpp,*.java,*.ps1 -Recurse | ForEach-Object {
		$FileStats = Get-Content $_.FullName | Measure-Object -line
		$CodeLines += $FileStats.Lines
		$Files++
	}

	$FolderName = (Get-Item "$Folder").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ 📂$FolderName contains $CodeLines lines of code in $Files files (took $Elapsed sec)" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}