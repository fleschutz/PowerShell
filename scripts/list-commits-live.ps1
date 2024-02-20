<#
.SYNOPSIS
	List commits live in real-time.
.DESCRIPTION
	This PowerShell script permanently lists the latest commit in a Git repository in real-time.
.PARAMETER RepoDir
	Specifies the file path to the local Git repository.
.EXAMPLE
	PS> ./commit-ticker.ps1
	❇️ Updated general.csv by Markus Fleschutz (HEAD -> main, origin/main, origin/HEAD)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	Write-Progress "Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "Checking file patch to Git repository..."
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	Write-Progress -completed "Done."

	$linePrev = ""
	for (;;) {
		& git -C "$RepoDir" fetch --all --recurse-submodules=no --jobs=1 --quiet
		if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

		$lineNow = (git -C "$RepoDir" log --format=format:'%s by %an%d' -n 1)
		if ($lineNow -ne $linePrev) {
			Write-Host "❇️ $lineNow"
			$linePrev = $lineNow
		}
		Start-Sleep -seconds 10
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
