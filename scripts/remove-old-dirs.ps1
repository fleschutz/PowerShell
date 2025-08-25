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
	PS> ./remove-old-dirs.ps1 C:\Temp 365
	⏳ Scanning C:\Temp for subfolders older than 365 days...
	⏳ Removing old 'TestFolder'...
	✅ Removed 1 of 49 subfolders in 1s.
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

	Write-Host "⏳ Searching in '$path' for subfolders older than $numDays days..."
	$numRemoved = 0
	$folders = Get-ChildItem -path "$path" -directory
	foreach ($folder in $folders) {
		[datetime]$folderDate = ($folder | Get-ItemProperty -Name LastWriteTime).LastWriteTime
		if ($folderDate -lt (Get-Date).AddDays(-$numDays)) {
			Write-Host "⏳ Removing old '$folder'..."
			$fullPath = $folder | Select-Object -ExpandProperty FullName
			Remove-Item -path "$fullPath" -force -recurse
			$numRemoved++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Removed $numRemoved of $($folders.Count) subfolders in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
