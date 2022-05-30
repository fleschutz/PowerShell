<#
.SYNOPSIS
	Checks symlinks in a folder
.DESCRIPTION
	This PowerShell script checks every symbolic link in a folder (including subfolders).
	It returns the number of broken symlinks as exit value.
.PARAMETER folder
	Specifies the path to the folder
.EXAMPLE
	PS> ./check-symlinks C:\Users
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Folder = "")

try {
	if ($Folder -eq "" ) { $Folder = read-host "Enter the path to the folder" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$FullPath = Resolve-Path "$Folder"
	"⏳ Checking symlinks at 📂$FullPath including subfolders..."

	[int]$NumTotal = [int]$NumBroken = 0
	Get-ChildItem $FullPath -recurse  | Where { $_.Attributes -match "ReparsePoint" } | ForEach-Object {
		$Symlink = $_.FullName
		$Target = ($_ | Select-Object -ExpandProperty Target -ErrorAction Ignore)
		if ($Target) {
			$path = $_.FullName + "\..\" + ($_ | Select-Object -ExpandProperty Target)
			$item = Get-Item $path -ErrorAction Ignore
			if (!$item) {
				$NumBroken++
				"Broken symlink #$($NumBroken): $Symlink ⭢ $Target"
			}
		}
		$NumTotal++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	if ($NumTotal -eq 0) {
		"✔️ found no symlink at 📂$FullPath in $Elapsed sec" 
	} elseif ($NumBroken -eq 0) {
		"✔️ found $NumTotal valid symlinks at 📂$FullPath in $Elapsed sec"
	} elseif ($NumBroken -eq 1) {
		"✔️ found $NumBroken broken symlink out of $NumTotal at 📂$FullPath in $Elapsed sec"
	} else {
		"✔️ found $NumBroken broken symlinks out of $NumTotal at 📂$FullPath in $Elapsed sec"
	}
	exit $NumBroken
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}