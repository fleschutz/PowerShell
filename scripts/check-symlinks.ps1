<#
.SYNOPSIS
	Checks all symlinks in a dir tree
.DESCRIPTION
	This PowerShell script checks all symbolic links in a directory tree. It returns the number of broken symlinks as exit value.
.PARAMETER path
	Specifies the file path to the directory tree
.EXAMPLE
	PS> ./check-symlinks D:\
	⏳ Checking symlinks at 'D:\'... (please wait)
	✅ Found 0 broken symlinks at 📂D:\ in 60s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the path to the folder" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$fullPath = Resolve-Path "$path"
	"⏳ Checking symlinks at '$fullPath'... (please wait)"

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
		"✅ No broken symlinks at $fullPath (found $numTotal symlinks, took $($elapsed)s)." 
	} elseif ($numBroken -eq 1) {
		"⚠️ 1 broken symlink at $fullPath (found $numTotal symlinks, took $($elapsed)s)."
	} else {
		"⚠️ $numBroken broken symlinks at $fullPath (found $numTotal symlinks, took $($elapsed)s)."
	}
	exit $numBroken
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
