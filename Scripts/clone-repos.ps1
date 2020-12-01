#!/snap/bin/powershell

# Syntax:       ./clone-repos.ps1
# Description:	clones well-known Git repositories
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$Repos = "https://github.com/fleschutz/PowerShell","https://github.com/fleschutz/CWTS"

foreach ($Repo in $Repos) {
	$Answer = read-host "Do you want to clone $Repo (y/n)"
	if ($Answer -eq "y") {
		git clone $Repos
	}
}

write-host "Done."
exit 0
