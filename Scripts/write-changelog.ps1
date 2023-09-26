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
 
try {
	#Set-Location (Split-Path $MyInvocation.MyCommand.Path)
	$branch = $args[0]
	$version = ($args[1]+"..")
	$path = $args[2]

	Write-Progress "Listing Git commits..."
	$commits = (git log --boundary --pretty=oneline --pretty=format:%s $version)

	Write-Progress "Sorting the Git commits..."
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
	Write-Progress "Writing output..."
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
	Write-Progress -completed " "
	exit 0 # success
} catch {
	Write-Error $_.Exception.ToString()
	exit 1
}