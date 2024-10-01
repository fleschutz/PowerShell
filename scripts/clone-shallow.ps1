<#
.SYNOPSIS
	Clones a shallow Git repo
.DESCRIPTION
	This PowerShell script clones popular Git repositories into a common target directory.
.PARAMETER URL
.PARAMETER branchName
.PARAMETER targetDir
	Specifies the file path to the target directory (current working directory by default)
.EXAMPLE
	PS> ./clone-shallow C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$targetDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$ git clone --branch $branchName --single-branch --depth 1 --recurse-submodules $URL $targetDir

	
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Cloned the shallow repository in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
