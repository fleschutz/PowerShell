<#
.SYNOPSIS
	Pulls repository updates 
.DESCRIPTION
	This PowerShell script pulls updates for the given local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./pull-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/3: Checking requirements... "
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	
	$Result = (git -C "$RepoDir" status)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	if ("$Result" -match "HEAD detached at ") {
		write-warning "Not on a branch, so nothing to pull (in detached HEAD state)"
		exit 0 # success
	} 

	"⏳ Step 2/3: Pulling updates... "
	& git -C "$RepoDir" pull --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	"⏳ Step 3/3: Updating submodules... "
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled updates for Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
