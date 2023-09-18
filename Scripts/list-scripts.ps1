<#
.SYNOPSIS
	Lists all PowerShell scripts
.DESCRIPTION
	This PowerShell script lists all PowerShell scripts in the repository (sorted alphabetically).
.EXAMPLE
	PS> ./list-scripts.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function ListScripts { param([string]$FilePath)
	Write-Progress "Reading $FilePath..."
	$table = Import-CSV "$FilePath"
	[int]$No = 1
	foreach($row in $table) {
		New-Object PSObject -Property @{
			'No' = $No++
			'Script' = $row.SCRIPT
			'Description' = $row.DESCRIPTION
		}
	}
	$global:NumScripts = $Table.Count
	Write-Progress -completed "."
}

try {
	ListScripts "$PSScriptRoot/../Data/scripts.csv" | Format-Table -property No,Script,Description
#	$files = Get-ChildItem -path "./*.ps1" -attributes !Directory
#	foreach ($file in $files) {
#		$help = Get-Help $file -full
#		Write-Output "$($file.Name),$($help.Synopsis),"
#	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
