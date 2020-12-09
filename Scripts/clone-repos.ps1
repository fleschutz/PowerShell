#!/snap/bin/powershell

# Syntax:       ./clone-repos.ps1
# Description:	clones well-known Git repositories into the current directory.
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$Repos = "https://github.com/commonmark/cmark", "https://github.com/opencv/opencv", "https://github.com/openzfs/zfs", "https://github.com/synesthesiam/voice2json", "https://github.com/fleschutz/CWTS", "https://github.com/fleschutz/cubesum", "https://github.com/fleschutz/PowerShell","https://github.com/fleschutz/CWTS", "https://github.com/fleschutz/eventdriven"

try {
	foreach ($Repo in $Repos) {
		$Answer = read-host "Do you want to clone $Repo (y/n)"
		if ($Answer -eq "y") {
			git clone $Repo
		}
	}

	write-host "Done."
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
