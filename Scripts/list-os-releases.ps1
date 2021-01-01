#!/snap/bin/powershell
<#
.SYNTAX         ./list-os-releases.ps1
.DESCRIPTION	lists OS releases and download URL
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	write-progress "Reading OS_IPFS_hashes.csv"
	$PathToRepo = (get-item $MyInvocation.MyCommand.Path).directory.parent
	$PathToCsvFile = "$PathToRepo/Data/os-release.csv"
	invoke-webRequest -URI "https://fleschutz.droppages.com/downloads/OS_IPFS_hashes.csv" -outFile "$PathToCsvFile"
	$Table = import-csv "$PathToCsvFile"
	remove-item -path "$PathToCsvFile"

	foreach ($Row in $Table) {
		write-output "* $($Row.Path) -> IPFS://$($Row.IPFS)"
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
