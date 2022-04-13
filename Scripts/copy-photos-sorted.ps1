<#
.SYNOPSIS
	Copy photos sorted by year and month
.DESCRIPTION
	This PowerShell script copies image files from SourceDir to TargetDir sorted by year and month.
.PARAMETER SourceDir
	Specifies the path to the source folder
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-photos-sorted D:\SmartPhone\DCIM C:\MyPhotoAlbum
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$SourceDir = "", [string]$TargetDir = "")

function CopyFile { param([string]$SourcePath, [string]$TargetDir, [int]$Date, [string]$Filename)
	[int]$Year = $Date / 10000
	[int]$Month = ($Date / 100) % 100
	$MonthDir = switch($Month) {
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
	$TargetPath = "$TargetDir/$Year/$MonthDir/$Filename"
	if (test-path "$TargetPath" -pathType leaf) {
		"Skipping $Filename: already existing..."
	} else {
		"Copying $Filename to $Year/$MonthDir..."
		new-item -path "$TargetDir" -name "$Year" -itemType "directory" -force | out-null
		new-item -path "$TargetDir/$Year" -name "$MonthDir" -itemType "directory" -force | out-null
		copy-item "$SourcePath" "$TargetPath" -force
	}
}

try {
	if ($SourceDir -eq "") { $SourceDir = read-host "Enter path to source directory" }
	if ($TargetDir -eq "") { $TargetDir = read-host "Enter path to target directory" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$Files = (Get-ChildItem "$SourceDir\*.jpg" -attributes !Directory)
	"Found $($Files.Count) photos in 📂$SourceDir..."
	foreach ($File in $Files) {
		$Filename = (Get-Item "$File").Name
		if ("$Filename" -like "IMG_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile "$File" "$TargetDir" $Array[1] "$Filename"
		} elseif ("$Filename" -like "IMG-*-*.jpg") {
			$Array = $Filename.split("-")
			CopyFile "$File" "$TargetDir" $Array[1] "$Filename"
		} elseif ("$Filename" -like "PANO_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile "$File"  "$TargetDir" $Array[1] "$Filename"
		} elseif ("$Filename" -like "PANO-*-*.jpg") {
			$Array = $Filename.split("-")
			CopyFile "$File" "$TargetDir" $Array[1] "$Filename"
		} elseif ("$Filename" -like "SAVE_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile "$File" "$TargetDir" $Array[1] "$Filename"
		} else {
			"Skipping $Filename: unknown filename format..."
		}
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ $($Files.Count) photos copied from 📂$SourceDir to 📂$TargetDir in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
