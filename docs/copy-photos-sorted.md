Script: *copy-photos-sorted.ps1*
========================

This PowerShell script copies image files from <sourceDir> to <targetDir> sorted by year and month.

Parameters
----------
```powershell
PS> ./copy-photos-sorted.ps1 [[-sourceDir] <String>] [[-targetDir] <String>] [<CommonParameters>]

-sourceDir <String>
    Specifies the path to the source folder
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-targetDir <String>
    Specifies the path to the target folder
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./copy-photos-sorted.ps1 D:\iPhone\DCIM C:\MyPhotos
⏳ Copying IMG_20240903_134445.jpg to C:\MyPhotos\2024\09 SEP\...
...
✅ 123 photos copied to 📂C:\MyPhotos in 13s (0 skipped).

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Copy photos sorted by year and month
.DESCRIPTION
	This PowerShell script copies image files from <sourceDir> to <targetDir> sorted by year and month.
.PARAMETER sourceDir
	Specifies the path to the source folder
.PARAMETER targetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-photos-sorted.ps1 D:\iPhone\DCIM C:\MyPhotos
	⏳ Copying IMG_20240903_134445.jpg to C:\MyPhotos\2024\09 SEP\...
	...
	✅ 123 photos copied to 📂C:\MyPhotos in 13s (0 skipped).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$sourceDir = "", [string]$targetDir = "")

function CopyPhoto([string]$sourcePath, [string]$targetDir, [int]$date, [string]$filename) {
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
		if ("$filename" -like "IMG_*_*.jpg") {
			$array = $filename.split("_")
			$skipped += CopyPhoto "$file" "$targetDir" $array[1] "$filename"
		} elseif ("$filename" -like "IMG-*-*.jpg") {
			$array = $filename.split("-")
			$skipped += CopyPhoto "$file" "$targetDir" $array[1] "$filename"
		} elseif ("$filename" -like "PANO_*_*.jpg") {
			$array = $filename.split("_")
			$skipped += CopyPhoto "$file"  "$targetDir" $array[1] "$filename"
		} elseif ("$filename" -like "PANO-*-*.jpg") {
			$array = $filename.split("-")
			$skipped += CopyPhoto "$file" "$targetDir" $array[1] "$filename"
		} elseif ("$filename" -like "SAVE_*_*.jpg") {
			$array = $filename.split("_")
			$skipped += CopyPhoto "$file" "$targetDir" $array[1] "$filename"
		} elseif ("$filename" -like "PXL_*_*.jpg") {
			$array = $filename.split("_")
			$skipped += CopyPhoto "$file" "$targetDir" $array[1] "$filename"
		} else {
			Write-Host "⏳ Skipping $filename with unknown filename format..."
			$skipped++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	[int]$copied = $files.Count - $skipped
	"✅ $copied photos copied to 📂$targetDir in $($elapsed)s ($skipped skipped)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:25)*
