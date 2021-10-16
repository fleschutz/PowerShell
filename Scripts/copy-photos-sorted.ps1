<#
.SYNOPSIS
	Copy image files sorted by year and month
.DESCRIPTION
	This script copies image files from SourceDir to TargetDir sorted by year and month.
.PARAMETER SourceDir
	Specifies the path to the image files
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-photos-sorted D:\Mobile\DCIM C:\MyPhotoAlbum
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$SourceDir = "", [string]$TargetDir = "")

function CopyFile { param([int]$Num, [string]$SrcPath, [string]$Filename, [int]$Date, [string]$DstDir)
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
	$DstPath = "$DstDir/$Year/$MonthDir/$Filename"
	if (test-path "$DstPath" -pathType leaf) {
		"#$($Num): $Filename exists already, skipping..."
	} else {
		"#$($Num): $Filename is copied..."
		new-item -path "$DstDir" -name "$Year" -itemType "directory" -force | out-null
		new-item -path "$DstDir/$Year" -name "$MonthDir" -itemType "directory" -force | out-null
		copy-item "$SrcPath" "$DstPath" -force
	}
}

try {
	if ($SourceDir -eq "") { $SourceDir = read-host "Enter path to source directory" }
	if ($TargetDir -eq "") { $TargetDir = read-host "Enter path to target directory" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$Files = (get-childItem "$SourceDir\*.jpg" -attributes !Directory)
	"Found $($Files.Count) photos in 📂$SourceDir..."
	[int]$Num = 0
	foreach ($File in $Files) {
		$Num++
		$Filename = (get-item "$File").Name
		if ("$Filename" -like "IMG_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile $Num "$File" "$Filename" $Array[1] "$TargetDir"
		} elseif ("$Filename" -like "IMG-*-*.jpg") {
			$Array = $Filename.split("-")
			CopyFile $Num "$File" "$Filename" $Array[1] "$TargetDir"
		} elseif ("$Filename" -like "PANO_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile $Num "$File" "$Filename" $Array[1] "$TargetDir"
		} elseif ("$Filename" -like "PANO-*-*.jpg") {
			$Array = $Filename.split("-")
			CopyFile $Num "$File" "$Filename" $Array[1] "$TargetDir"
		} else {
			"#$($Num): $Filename with unknown filename format"
		}
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ copied $Num photos to 📂$TargetDir sorted by year and month in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
