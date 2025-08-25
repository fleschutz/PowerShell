<#
.SYNOPSIS
	Copy videos sorted by year and month
.DESCRIPTION
	This PowerShell script copies video files from <sourceDir> to <targetDir> sorted by year and month.
.PARAMETER sourceDir
	Specifies the path to the source folder
.PARAMETER targetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-videos-sorted.ps1 D:\iPhone\DCIM C:\MyVideos
	...
	✅ 123 videos copied to 📂C:\MyVideos in 13s (0 skipped).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$sourceDir = "", [string]$targetDir = "")

function CopyVideo([string]$sourcePath, [string]$targetDir, [int]$date, [string]$filename) {
	[int]$year = $date / 10000
	[int]$month = ($date / 100) % 100
	$monthDir = switch($month) {
	1  {"01 JAN"}
	2  {"02 FEB"}
	3  {"03 MAR"}
	4  {"04 APR"}
	5  {"05 MAY"}
	6  {"06 JUN"}
	7  {"07 JUL"}
	8  {"08 AUG"}
	9  {"09 SEP"}
	10 {"10 OCT"}
	11 {"11 NOV"}
	12 {"12 DEC"}
	}
	$TargetPath = "$targetDir/$year/$monthDir/$filename"
	if (Test-Path "$TargetPath" -pathType leaf) {
		Write-Host "⏳ Skipping existing $targetDir\$year\$monthDir\$filename..."
		return 1
	}
	Write-Host "⏳ Copying $filename to $targetDir\$year\$monthDir\..."
	New-Item -path "$targetDir" -name "$year" -itemType "directory" -force | out-null
	New-Item -path "$targetDir/$year" -name "$monthDir" -itemType "directory" -force | out-null
	Copy-Item "$sourcePath" "$TargetPath" -force
	return 0
}

try {
	if ($sourceDir -eq "") { $sourceDir = Read-Host "Enter file path to the source directory" }
	if ($targetDir -eq "") { $targetDir = Read-Host "Enter file path to the target directory" }
	$stopWatch = [system.diagnostics.stopWatch]::startNew()

	Write-Host "⏳ Checking source directory 📂$($sourceDir)..."
	if (-not(Test-Path "$sourceDir" -pathType container)) { throw "Can't access source directory: $sourceDir" }
	$files = (Get-ChildItem "$sourceDir\*.jpg" -attributes !Directory)

	Write-Host "⏳ Checking target directory 📂$($targetDir)..."
	if (-not(Test-Path "$targetDir" -pathType container)) { throw "Can't access target directory: $targetDir" }

	[int]$skipped = 0
	foreach($file in $files) {
		$filename = (Get-Item "$file").Name
		if ("$filename" -like "VID_*_*.mp4") {
			$array = $filename.split("_")
			$skipped += CopyVideo "$file" "$targetDir" $array[1] "$filename"
		} else {
			Write-Host "⏳ Skipping $filename (no video format)..."
			$skipped++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	[int]$copied = $files.Count - $skipped
	"✅ $copied videos copied to 📂$targetDir in $($elapsed)s ($skipped skipped)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
