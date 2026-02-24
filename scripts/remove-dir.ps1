<#
.SYNOPSIS
        Removes a directory
.DESCRIPTION
        This PowerShell script removes the given directory. It removes all files and all subfolders in the directory!
	IMPORTANT NOTE: Use with care! This cannot be undone!
.PARAMETER path
        Specifies the path to the directory tree to remove
.EXAMPLE
        PS> ./remove-dir.ps1 C:\Temp
	⏳ Removing directory tree at: C:\Temp... (please wait)
	✅ Removed 'C:\Temp\' in 9s.
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the path to the directory to remove" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!(Test-Path "$path" -pathType container)) { throw "Cannot access directory at: '$path'" }

	"⏳ Removing directory tree at: $path ... (please wait)"
	$lastExitCode = 0
	Remove-Item -force -recurse -confirm:$false $path
	if ($lastExitCode -ne 0) { throw "'Remove-Item $path' failed with exit code $lastExitCode" }
	if (Test-Path "$path" -pathType container) { throw "Removal of '$path' failed, it's still available" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Removed '$path' in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
