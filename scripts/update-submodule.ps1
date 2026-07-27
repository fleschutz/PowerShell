<#
.SYNOPSIS
	Updates a submodule in a Git repository
.DESCRIPTION
	This PowerShell script updates a single submodule in the given Git repository.
.PARAMETER Submodule
	Specifies the path to the submodule
.PARAMETER RepoDir
	Specifies the path to the repository (current working directory by default)
.EXAMPLE
	PS> ./update-submodule.ps1 libSI
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Submodule = "", [string]$RepoDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/9) Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ (2/9) Checking the local repository..."
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access local repository: $RepoDir" }
	if (-not(Test-Path "$RepoDir/$Submodule" -pathType container)) { throw "Can't access submodule: $RepoDir/$Submodule" }

	"⏳ (3/9) Initializing and updating the submodules (for safety)..."
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne 0) { throw "'git submodule update' failed" }

	"⏳ (4/9) Fetching the latest changes in '$Submodule'..."
	& git -C "$RepoDir/$Submodule" fetch
	if ($lastExitCode -ne 0) { throw "'git fetch' failed" }

	"⏳ (5/9) Checkout the latest commit in '$Submodule'..."
	& git -C "$RepoDir/$Submodule" checkout main
	if ($lastExitCode -ne 0) { throw "'git checkout main' failed" }

	"⏳ (6/9) Pulling the latest changes in '$Submodule'..."
	& git -C "$RepoDir/$Submodule" pull origin main
	if ($lastExitCode -ne 0) { throw "'git pull origin main' failed" }

	"⏳ (7/9) Updating the submodule reference..."
	& git -C "$RepoDir" add $Submodule
	if ($lastExitCode -ne 0) { throw "'git add' failed" }

	"⏳ (8/9) Committing the change..."
	& git -C "$RepoDir" commit -m "Updated $Submodule to latest commit"
	if ($lastExitCode -ne 0) { throw "'git commit' failed" }

	"⏳ (9/9) Pushing the changes..."
	& git -C "$RepoDir" push origin main
	if ($lastExitCode -ne 0) { throw "'git push origin main' failed" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Updated submodule '$Submodule' in Git repo 📂$RepoDir in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
