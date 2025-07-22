<#
.SYNOPSIS
        Removes a dir tree
.DESCRIPTION
        This PowerShell script silently removes a directory tree recursively. Use it with care!
.PARAMETER pathToDirTree
        Specifies the file path to the directory tree
.EXAMPLE
        PS> ./remove-dir-tree.ps1 C:\Temp
	✅ Removed directory 'C:\Temp\ in 9s.
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToDirTree = "")

try {
	if ($pathToDirTree -eq "" ) { $pathToDirTree = Read-Host "Enter the path to the directory tree" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Remove-Item -Force -Recurse -Confirm:$false $pathToDirTree
	if ($lastExitCode -ne 0) { throw "'Remove-Item' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Removed directory '$pathToDirTree' in $($elapsed)s."
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
