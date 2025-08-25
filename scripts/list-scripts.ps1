<#
.SYNOPSIS
	Lists the PowerShell scripts
.DESCRIPTION
	This PowerShell script lists the Mega collection of PowerShell scripts (sorted alphabetically and optionally by category).
.PARAM category
	Specifies the desired category: audio, desktop, filesystem, fun, git, misc, or: * (default)
.EXAMPLE
	PS> ./list-scripts.ps1

	 No Script                    Category   Description
	 -- ------                    --------   -----------
	  1 add-firewall-rules.ps1    misc       Adds firewall rules for executables (needs admin rights)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$category = "*")

function ListScripts([string]$category) { 
	Write-Progress "Loading data from ../data/script.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/scripts.csv"
	[int]$No = 1
	foreach($row in $table) {
		if ($row.CATEGORY -like $category) { 
			New-Object PSObject -Property @{
				'No' = $No++
				'Script' = $row.SCRIPT
				'Category' = $row.CATEGORY
				'Description' = $row.DESCRIPTION
			}
		}
	}
	Write-Progress -completed " "
}

try {
	ListScripts $category | Format-Table -property No,Script,Category,Description
#	$files = Get-ChildItem -path "./*.ps1" -attributes !Directory
#	foreach ($file in $files) {
#		$help = Get-Help $file -full
#		Write-Output "$($file.Name), ,`"$($help.Synopsis)`","
#	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
