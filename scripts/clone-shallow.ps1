<#
.SYNOPSIS
	Clones a shallow Git repo
.DESCRIPTION
	This PowerShell script clones a shallow Git repository for speed and disk space (1 branch and 1 commit only, no blobs).
.PARAMETER URL
	Specifies the URL to the remote Git repository (queried if none given)
.PARAMETER branchName
	Specifies the branch name ('main' by default)
.EXAMPLE
	PS> ./clone-shallow.ps1 https://github.com/fleschutz/PowerShell.git
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$URL = "", [string]$branchName = "main")

try {
	if ($URL -eq "") { $URL = Read-Host "Enter the URL to the remote Git repository" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	& git clone $URL --depth 1 --single-branch --branch $branchName --filter=blob:none --recurse-submodules --shallow-submodules --jobs 4
	
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Cloned '$branchName' branch from $URL in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
