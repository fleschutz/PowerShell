<#
.SYNOPSIS
        Lists the SSH key
.DESCRIPTION
        This PowerShell script lists the user's public SSH key.
.EXAMPLE
        PS> ./list-ssh-key.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	if (Test-Path "~/.ssh/id_ed25519.pub") {
		$key = Get-Content "~/.ssh/id_ed25519.pub"
		"✅ Public SSH key is: $key"
	} elseif (Test-Path "~/.ssh/id_rsa.pub") {
		$key = Get-Content "~/.ssh/id_rsa.pub"
		"✅ Public SSH key is: $key"
	} else {
		"⚠️ No SSH key found"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
