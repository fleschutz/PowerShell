<#
.SYNOPSIS
	check-symlinks.ps1 [<DirTree>]
.DESCRIPTION
	Checks every symlink in a directory tree.
.EXAMPLE
	PS> ./check-symlinks .
	✔️ 0 out of 10 symlinks are broken in 📂/home/markus
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$DirTree = "")

try {
	if ($DirTree -eq "" ) { $DirTree = read-host "Enter the path to the directory tree" }

	$FullPath = Resolve-Path "$DirTree"
	write-progress "Checking every symlink in 📂$FullPath..."
	[int]$NumTotal = [int]$NumBroken = 0
	Get-ChildItem $FullPath -recurse  | Where { $_.Attributes -match "ReparsePoint" } | ForEach-Object {
		$Symlink = $_.FullName
		$Target = ($_ | Select-Object -ExpandProperty Target -ErrorAction Ignore)
		if ($Target) {
			$path = $_.FullName + "\..\" + ($_ | Select-Object -ExpandProperty Target)
			$item = Get-Item $path -ErrorAction Ignore
			if (!$item) {
				write-warning "Broken symlink $Symlink -> $Target"
				$NumBroken++
			}
		}
		$NumTotal++
	}

	"✔️ $NumBroken out of $NumTotal symlinks are broken in 📂$FullPath"
	exit $NumBroken
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
