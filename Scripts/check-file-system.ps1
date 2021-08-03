<#
.SYNOPSIS
	check-file-system.ps1 [<drive>] 
.DESCRIPTION
	Checks the validity of the file system (needs admin rights)
.EXAMPLE
	PS> .\check-file-system.ps1 C
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

#Requires -RunAsAdministrator

param([string]$Drive = "")

if ($Drive -eq "" ) {
	$Drive = read-host "Enter drive (letter) to check"
}

try {
	$Result = repair-volume -driveLetter $Drive -scan
	if ($Result -ne "NoErrorsFound") { throw "'repair-volume' failed" }

	write-host -foregroundColor green "✔️ file system on drive $Drive is clean"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
