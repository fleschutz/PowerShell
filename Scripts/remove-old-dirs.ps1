<#
.SYNOPSIS
	Removes old directories
.DESCRIPTION
	This PowerShell script removes any subfolder in a parent folder older than <numDays> (using last write time).
.PARAMETER path
	Specifies the file path to the parent folder
.PARAMETER numDays
	Specifies the number of days (1000 by default)
.EXAMPLE
	PS> ./remove-old-dirs.ps1 C:\Temp 90
.NOTES
	Author: Markus Fleschutz
#>

param([string]$path = "", [int]$numDays = 1000)

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if ("$path" -eq "") { $path = Read-Host "Enter the file path to the parent folder" }
	if (!(Test-Path -Path "$path" -PathType container)) { throw "Given path doesn't exist - enter a valid path, please" }

	Write-Host "⏳ Removing subfolders older than $numDays days in $path..."
	$folders = Get-ChildItem -path "$path" -directory
	$numRemoved = 0
	$count = 0
	foreach ($folder in $folders) {
		[datetime]$folderDate = ($folder | Get-ItemProperty -Name LastWriteTime).LastWriteTime
		$count++
		if ($folderDate -lt (Get-Date).AddDays(-$numDays)) {
			Write-Host "($($count)) Removing old '$folder'..."
			$fullPath = $folder | Select-Object -ExpandProperty FullName
			Remove-Item -path "$fullPath" -force -recurse
			$numRemoved++
		} else {
			Write-Host "($($count)) Skipping young '$folder'..."
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Removed $numRemoved of $count subfolders older than $numDays days in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
