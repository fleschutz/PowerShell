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
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "", [int]$numDays = 1000)

try {
	if ("$path" -eq "") { $path = Read-Host "Enter the file path to the parent folder" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!(Test-Path -Path "$path" -PathType container)) { throw "Given path doesn't exist - enter a valid path, please" }

	Write-Host "⏳ Searching for subfolders at '$path' older than $numDays days..."
	$numRemoved = $numSkipped = 0
	$folders = Get-ChildItem -path "$path" -directory
	foreach ($folder in $folders) {
		[datetime]$folderDate = ($folder | Get-ItemProperty -Name LastWriteTime).LastWriteTime
		if ($folderDate -lt (Get-Date).AddDays(-$numDays)) {
			Write-Host "Removing old '$folder'..."
			$fullPath = $folder | Select-Object -ExpandProperty FullName
			Remove-Item -path "$fullPath" -force -recurse
			$numRemoved++
		} else {
			$numSkipped++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Removed $numRemoved subfolders older than $numDays days in $($elapsed)s ($numSkipped skipped)."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
