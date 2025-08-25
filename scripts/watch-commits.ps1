<#
.SYNOPSIS
	Watch Git commits live.
.DESCRIPTION
	This PowerShell script continuously lists the latest commits in a Git repository in real-time.
.PARAMETER pathToRepo
	Specifies the file path to the local Git repository.
.EXAMPLE
	PS> ./watch-commits.ps1

	TIME   COMMIT
	----   ------
	11:25  Updated general.csv by Markus Fleschutz (HEAD -> main, origin/main, origin/HEAD)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD", [int]$updateInterval = 60, [int]$speed = 10)

try {
	Write-Progress "Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "Checking local Git repository..."
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access directory: $pathToRepo" }
	Write-Progress -completed "Done."

	Write-Output ""
	Write-Output "TIME   COMMIT"
	Write-Output "----   ------"
	$prevLine = ""
	$tzOffset = (Get-Timezone).BaseUtcOffset.TotalSeconds
	for (;;) {
		& git -C "$pathToRepo" fetch --all --recurse-submodules=no --jobs=1 --quiet
		if ($lastExitCode -ne 0) { throw "'git fetch' failed" }

		$line = (git -C "$pathToRepo" log origin --format=format:'%at %s by %an%d' --max-count=1)
		if ($lastExitCode -ne 0) { throw "'git log origin' failed" }
		if ("$line" -eq "$prevLine") { Start-Sleep -seconds $updateInterval; continue }

		$unixTimestamp = [int64]$line.Substring(0,10)
		$time = (Get-Date -day 1 -month 1 -year 1970 -hour 0 -minute 0 -second 0).AddSeconds($unixTimestamp)
		$time = $time.AddSeconds($tzOffset)
		$timeString = $time.ToString("HH:mm")
		$message = $line.Substring(11)
		& "$PSScriptRoot/write-typewriter.ps1" "$timeString  $message" $speed
		$prevLine = $line
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
