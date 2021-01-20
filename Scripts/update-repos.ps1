#!/snap/bin/powershell
<#
.SYNTAX         ./update-repos.ps1 [<directory>]
.DESCRIPTION	updates all Git repositories under the current directory
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Directory = "")

try {
	if ($Directory -eq "") {
		$Directory = "$PWD"
	}
	$Items = get-childItem -path $Directory
	foreach ($Item in $Items) {
		if ($Item.Mode -eq "d-----") {
			$Filename = $Item.Name
			set-location $Filename
			git pull
			set-location ..
		} 
	}
	write-output "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
