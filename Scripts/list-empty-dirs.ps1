<#
.SYNOPSIS
	Lists empty subfolders
.DESCRIPTION
	This PowerShell script scans and lists all empty subfolders within the given directory tree.
.PARAMETER DirTree
	Specifies the path to the directory tree (current working directory by default)
.EXAMPLE
	PS> ./list-empty-dirs C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$DirTree = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$DirTree = Resolve-Path "$DirTree"
	Write-Progress "Listing empty subfolders in $DirTree..."
	[int]$Count = 0
	Get-ChildItem "$DirTree" -attributes Directory -recurse | Where {$_.GetFileSystemInfos().Count -eq 0} | ForEach-Object {
		"📂$($_.FullName)"
		$Count++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ found $Count empty subfolders within directory tree $DirTree in $Elapsed sec." 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}