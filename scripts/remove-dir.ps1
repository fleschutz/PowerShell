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
	⏳ Removing 'C:\Temp'...      (please wait)"
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
	"⏳ Removing '$pathToDir'...      (please wait)"

	Remove-Item -Force -Recurse -Confirm:$false $pathToDir
	if ($lastExitCode -ne 0) { throw "'Remove-Item' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Directory $pathToDir removed (took $($elapsed)s)."
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
