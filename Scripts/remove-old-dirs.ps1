<#
.SYNOPSIS
	Removes old directories
.DESCRIPTION
	This PowerShell script removes any directory in a given folder older than <numDays> (using last write time).
.PARAMETER path
	Specifies the file path to the folder
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
	if ("$path" -eq "") { $path = Read-Host "Enter the file path to the directory" }
	if (!(Test-Path -Path "$path" -PathType container)) { throw "Given path doesn't exist - enter a valid path, please" }

	Write-Progress "Removing old directories in $path..."
	$folders = Get-ChildItem -Path "$path" -Directory
	$numRemoved = 0
	$count = 0
	foreach ($folder in $folders) {
		[datetime]$folderDate = ($folder | Get-ItemProperty -Name LastWriteTime).LastWriteTime
		$count++
		if ($folderDate -lt (Get-Date).AddDays(-$numDays)) {
			Write-Host "#$($count): Removing old '$folder'..."
                	$fullPath = $folder | Select-Object -ExpandProperty FullName
                	Remove-Item -Path $fullPath -Force -Recurse
			$numRemoved++
           	} else {
			Write-Host "#$($count): Skipping '$folder' (too young)..."
		}
        }
	Write-Progress -completed "."
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	Write-Host "Removed $numRemoved of $count directories older than $numDays days at $path in $elapsed sec"
	exit 0 # success
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1 # failure
}
