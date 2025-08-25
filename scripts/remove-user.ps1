<#
.SYNOPSIS
	Removes an user account
.DESCRIPTION
	This PowerShell script removes an existing user account including the home directory.
.EXAMPLE
	PS> ./remove-user.ps1 Joe
	✅ Removed user 'Joe' including home directory in 11s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$username = "")

try {
	if ($username -eq "") { $username = Read-Host "Enter the user name to remove" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		&  sudo deluser --remove-home $username
	} else {
		throw "Not supported yet"
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Removed user '$username' including home directory in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
