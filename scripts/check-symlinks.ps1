﻿<#
.SYNOPSIS
	Checks all symlinks in a dir tree
.DESCRIPTION
	This PowerShell script checks all symbolic links in a directory tree. It returns the number of broken symlinks as exit value.
.PARAMETER path
	Specifies the file path to the directory tree
.EXAMPLE
	PS> ./check-symlinks C:\Windows
	⏳ Checking symlinks at C:\Windows including subfolders...
	✅ No symlinks at C:\Windows (took 102s).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the file path to the directory tree" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$fullPath = Resolve-Path "$path"
	"⏳ Checking symlinks at $fullPath including subfolders..."

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
		"✅ No symlinks at $fullPath (took $($elapsed)s)." 
	} elseif ($numBroken -eq 0) {
		"✅ No broken symlinks at $fullPath ($numTotal symlinks in total, took $($elapsed)s)." 
	} elseif ($numBroken -eq 1) {
		"⚠️ 1 broken symlink within $fullPath ($numTotal symlinks in total, took $($elapsed)s)."
	} else {
		"⚠️ $numBroken broken symlinks within $fullPath ($numTotal symlinks in total, took $($elapsed)s)."
	}
	exit $numBroken
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
