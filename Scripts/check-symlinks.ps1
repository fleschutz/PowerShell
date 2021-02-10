#!/bin/powershell
<#
.SYNTAX         ./check-symlinks.ps1 [<dir-tree>]
.DESCRIPTION	checks every symlink in the given directory tree
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($DirTree = "")

try {
	if ($DirTree -eq "" ) {
		$DirTree = read-host "Enter the path to the directory tree"
	}

	[int]$SymlinksTotal = [int]$SymlinksBroken = 0
	gci $DirTree -Recurse  | Where { $_.Attributes -match "ReparsePoint" } | ForEach-Object {
		$Symlink = $_.FullName
		$Target = ($_ | Select-Object -ExpandProperty Target -ErrorAction Ignore)
		if ($Target) {
			$path = $_.FullName + "\..\" + ($_ | Select-Object -ExpandProperty Target)
			$item = Get-Item $path -ErrorAction Ignore
			if (!$item) {
				write-warning "Broken symlink: $Symlink -> $Target"
				$SymlinksBroken++
			}
		}
		$SymlinksTotal++
	}
	write-output "Done - found $SymlinksTotal symlinks total, $SymlinksBroken are broken"
	exit $SymlinksBroken
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
