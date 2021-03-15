#!/bin/powershell
<#
.SYNTAX         ./check-drive-space.ps1 [<drive>] [<min-level>]
.DESCRIPTION	checks the given drive for free space left
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Drive = "", [int]$MinLevel = 50) # minimum level in GB

if ($Drive -eq "" ) {
	$Drive = read-host "Enter drive to check"
}

try {
	$DriveDetails = (get-psdrive $Drive)
	[int]$FreeSpace = (($DriveDetails.Free / 1024) / 1024) / 1024
	[int]$InUse = (($DriveDetails.Used / 1024) / 1024) / 1024
	[int]$Total = ($InUse + $FreeSpace)

	if ($FreeSpace -lt $MinLevel) {
        	write-warning "Drive $Drive has only $FreeSpace GB left to use! ($InUse GB out of $Total GB in use, minimum is $MinLevel GB)"
		exit 1
	}
	write-host -foregroundColor green "OK - drive $Drive has $FreeSpace GB left to use ($InUse GB out of $Total GB in use, minimum is $MinLevel GB)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
