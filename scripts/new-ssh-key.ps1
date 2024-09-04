<#
.SYNOPSIS
        Creates a new SSH key
.DESCRIPTION
        This PowerShell script creates a new SSH key for the user.
.EXAMPLE
        PS> ./new-ssh-key.ps1
		✔️ Your public key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILb8s5zU9YDApGQ82H45fMKVPMr5cw9fzh3PEBjZZ+Rm markus@PI
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	& ssh-keygen
	if ($lastExitCode -ne "0") { throw "ssh-keygen failed" }

	if (Test-Path "~/.ssh/id_ed25519.pub") {
		$publicKey = Get-Content "~/.ssh/id_ed25519.pub"
	} elseif (Test-Path "~/.ssh/id_rsa.pub") {
		$publicKey = Get-Content "~/.ssh/id_rsa.pub"
	} else {
		throw "No public key found."
	}
	"✔️ Your public key: $publicKey"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}