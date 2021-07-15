<#
.SYNOPSIS
	copy-photos-sorted.ps1 [<source-dir>] [<target-dir-tree>]
.DESCRIPTION
	Copies all photos in source-dir sorted by year and month into the target-dir-tree
.EXAMPLE
	PS> .\copy-photos-sorted.ps1 C:\MyPhotos C:\MyPhotoAlbum
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$SourceDir = "", [string]$TargetDirTree = "")

function CopyFile { param([string]$File, [string]$Filename, [int]$Date, [string]$TargetDir)
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
	$TargetFile = "$TargetDirTree/$Year/$MonthDir/$Filename"
	"Copying to $TargetFile ..."
	copy-item "$File" "$TargetFile" -force
}

try {
	if ($SourceDir -eq "") { $SourceDir = read-host "Enter source directory" }
	if ($TargetDirTree -eq "") { $TargetDirTree = read-host "Enter target directory tree" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$Files = (get-childItem "$SourceDir\*.jpg" -attributes !Directory)
	[int]$Count = 0
	foreach ($File in $Files) {
		$Filename = (get-item "$File").Name
		if ("$Filename" -like "IMG_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile $File $Filename $Array[1] $TargetDirTree
			$Count++
		} elseif ("$Filename" -like "PANO_*_*.jpg") {
			$Array = $Filename.split("_")
			CopyFile $Filen $Filename $Array[1] $TargetDirTree
			$Count++
		} else {
			"Unknown filename format: $Filename"
		}
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ copied $Count photos sorted into 📂$TargetDirTree in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
