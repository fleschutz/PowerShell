<#
.SYNOPSIS
	Copy a single image into a series of pixelated images
.DESCRIPTION
	This PowerShell script copies a single image file into a series of pixelated images in a target dir.
.PARAMETER SourceFile
	Specifies the path to the image source file
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-image-pixelated C:\my_photo.jpg C:\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$SourceFile = "", [string]$TargetDir = "")

try {
	if ($SourceFile -eq "") { $SourceFile = Read-Host "Enter file path to source image file" }
	if ($TargetDir -eq "") { $TargetDir = Read-Host "Enter file path to target directory" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Basename = (Get-Item "$SourceFile").Basename
	$Factor = 0.001
	for ($i = 0; $i -lt 300; $i++) {
		$TargetFile = "$TargetDir/$($Basename)_$($i).jpg"
		Write-Host "⏳ Copying $SourceFile to $TargetFile with pixelation factor $Factor..."
		$Coeff1 = 100.0 * $Factor
		$Coeff2 = 100.0 / $Factor
		& convert -scale $Coeff1% -scale $Coeff2% "$SourceFile" "$TargetFile"
		$Factor += 0.0005
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ copied $SourceFile to a series of 300 pixelated images in 📂$TargetDir in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
