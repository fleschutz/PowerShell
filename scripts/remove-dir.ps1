<#
.SYNOPSIS
        Removes a directory
.DESCRIPTION
        This PowerShell script removes the given directory tree recursively.
	NOTE: Use with care! This cannot be undone!
.PARAMETER pathToDir
        Specifies the file path to the directory tree
.EXAMPLE
        PS> ./remove-dir.ps1 C:\Temp
	⏳ Removing directory 'C:\Temp', please wait..."
	✅ Directory C:\Temp\ removed (took 9s).
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToDir = "")

try {
	if ($pathToDir -eq "" ) { $pathToDir = Read-Host "Enter the file path to the obsolete directory" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!(Test-Path "$pathToDir" -pathType container)) { throw "Cannot access directory '$pathToDir'" }

	"⏳ Removing directory '$pathToDir', please wait..."
	Remove-Item -force -recurse -confirm:$false $pathToDir
	if ($lastExitCode -ne 0) { throw "'Remove-Item' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Directory $pathToDir removed (took $($elapsed)s)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
        exit 1
}
