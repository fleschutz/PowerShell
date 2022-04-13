<#
.SYNOPSIS
	Creates a new user account
.DESCRIPTION
	This PowerShell script creates a new user account.
.EXAMPLE
	PS> ./new-user
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Username = "")

try {
	if ($Username -eq "") { $Username = read-host "Enter new user name" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		& sudo adduser --encrypt-home $Username
	} else {
		throw "Not supported yet"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new user '$Username' with encrypted home directory in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
