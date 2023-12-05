<#
.SYNOPSIS
	Creates a new user account
.DESCRIPTION
	This PowerShell script creates a new user account with an encrypted home directory.
.EXAMPLE
	PS> ./new-user.ps1 Joe
	✔️ Created new user 'Joe' with encrypted home directory in 11 sec
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
		& sudo adduser --encrypt-home $username
	} else {
		throw "Not supported yet"
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Created new user '$username' with encrypted home directory in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
