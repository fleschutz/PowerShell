<#
.SYNOPSIS
	Checks all symlinks in a folder
.DESCRIPTION
	This PowerShell script checks all symbolic links in a directory tree. It returns the number of broken symlinks as exit value.
.PARAMETER folder
	Specifies the path to the folder
.EXAMPLE
	PS> ./check-symlinks D:\
	⏳ Please wait while checking symlinks at: 📂D:\ ...
	✅ Found 0 broken symlinks at 📂D:\ in 60s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Folder = "")

try {
	if ($Folder -eq "" ) { $Folder = Read-Host "Enter the path to the folder" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$fullPath = Resolve-Path "$Folder"
	"⏳ Please wait while checking symlinks at 📂$fullPath ..."

	[int]$numTotal = [int]$numBroken = 0
	Get-ChildItem $fullPath -recurse  | Where { $_.Attributes -match "ReparsePoint" } | ForEach-Object {
		$Symlink = $_.FullName
		$Target = ($_ | Select-Object -ExpandProperty Target -ErrorAction Ignore)
		if ($Target) {
			$path = $_.FullName + "\..\" + ($_ | Select-Object -ExpandProperty Target)
			$item = Get-Item $path -ErrorAction Ignore
			if (!$item) {
				$numBroken++
				"Broken symlink #$($numBroken) at $Symlink linking to: $Target"
			}
		}
		$numTotal++
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	if ($numTotal -eq 0) {
		"✅ No symlink found at 📂$fullPath in $($elapsed)s." 
	} elseif ($numBroken -eq 1) {
		"✅ Found $numBroken broken symlink at 📂$fullPath in $($elapsed)s ($numTotal symlinks in total)."
	} else {
		"✅ Found $numBroken broken symlinks at 📂$fullPath in $($elapsed)s ($numTotal symlinks in total)."
	}
	exit $numBroken
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
