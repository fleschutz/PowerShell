#!/snap/bin/powershell
<#
.SYNTAX         ./clone-repos.ps1
.DESCRIPTION	clones well-known Git repositories into the current directory.
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$Repos = "https://github.com/commonmark/cmark", "https://github.com/opencv/opencv", "https://github.com/openzfs/zfs", "https://github.com/synesthesiam/voice2json", "https://github.com/fleschutz/CWTS", "https://github.com/fleschutz/cubesum", "https://github.com/fleschutz/PowerShell","https://github.com/fleschutz/CWTS", "https://github.com/fleschutz/eventdriven"

try {
	foreach ($Repo in $Repos) {
		$Answer = read-host "Do you want to clone $Repo (y/n)"
		if ($Answer -eq "y") {
			git clone $Repo
		}
	}

	write-output "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
