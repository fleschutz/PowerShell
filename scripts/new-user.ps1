<#
.SYNOPSIS
	Create a new user
.DESCRIPTION
	This PowerShell script creates a new user account with an encrypted home directory.
.EXAMPLE
	PS> ./new-user.ps1 Joe
	✅ Created user account 'Joe' with encrypted home directory in 11s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$username = "")

try {
	if ($username -eq "") { $username = Read-Host "Enter the new user name" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
 		& sudo apt install ecryptfs-utils
		& sudo adduser --encrypt-home $username
	} else {
		throw "Not supported yet"
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Created user account '$username' with encrypted home directory in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
