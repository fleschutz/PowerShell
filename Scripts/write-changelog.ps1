<#
.SYNOPSIS
        Writes a changelog
.DESCRIPTION
        This PowerShell script writes a changelog by using the Git commits.
.EXAMPLE
        PS> ./write-changelog.ps1
	  
	1. New Features
	---------------
	...
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")
 
try {
        $StopWatch = [system.diagnostics.stopwatch]::startNew()
	$branch = $args[0]
	$version = ($args[1]+"..")
	$path = $args[2]

	Write-Progress "⏳ (1/5) Searching for Git executable..."
        $null = (git --version)
        if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "⏳ (2/5) Checking local repository..."
        if (!(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }

	Write-Progress "⏳ (3/5) Fetching commits..."
        & git -C "$RepoDir" fetch --all --force --quiet
        if ($lastExitCode -ne "0") { throw "'git fetch --all' failed with exit code $lastExitCode" }

	Write-Progress "⏳ (4/5) Listing Git commits..."
	$commits = (git -C "$RepoDir" log --boundary --pretty=oneline --pretty=format:%s)

	Write-Progress "⏳ (5/5) Sorting the Git commits..."
	$features = @()
	$fixes = @()
	$updates = @()
	$other = @()
	foreach($commit in $commits) {
 		if ($commit -like "New*") {
 			$features += $commit
		} elseif ($commit -like "Add*") {
 			$features += $commit
		} elseif ($commit -like "Create*") {
 			$features += $commit
		} elseif ($commit -like "Fix*") {
 			$fixes += $commit
 		} elseif ($commit -like "Hotfix*") {
 			$fixes += $commit
		} elseif ($commit -like "Update*") {
 			$updates += $commit
		} elseif ($commit -like "Updaate*") {
 			$updates += $commit
		} elseif ($commit -like "Improve*") {
 			$updates += $commit
		} elseif ($commit -like "Change*") {
 			$updates += $commit
 		} else {
			$other += $commit
		}
 	}
	Write-Progress -completed " "
	$tab = "    "
	Write-Output " "
	Write-Output "1. New Features"
	Write-Output "---------------"
 	foreach($c in $features) {
 		Write-Output ($tab + "- " + $c)
	}
	Write-Output " "
 	Write-Output "2. Hotfixes"
	Write-Output "-----------"
 	foreach($c in $fixes) {
 		Write-Output ($tab + "- " + $c)
 	}
	Write-Output " "
	Write-Output "3. Updates"
	Write-Output "----------"
	foreach($c in $updates) {
		Write-Output ($tab + "- " + $c)
	}
	Write-Output " "
	Write-Output "4. Various Changes"
	Write-Output "------------------"
	foreach($c in $other) {
		Write-Output ($tab + "- " + $c)
	}
	exit 0 # success
} catch {
	Write-Error $_.Exception.ToString()
	exit 1
}