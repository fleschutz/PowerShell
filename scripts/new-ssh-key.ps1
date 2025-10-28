<#
.SYNOPSIS
	Create a new SSH key
.DESCRIPTION
	This PowerShell script creates a new personal SSH key for the user (needed for remote login, Git, etc.). 
.EXAMPLE
	PS> ./new-ssh-key.ps1
	✅ Your new SSH key has been saved to ~/.ssh (Ed25519 type). The public key is:
	ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILb8s5zU9YDApGQ82H45fMKVPMr5cw9fzh3PEBjZZ+Rm markus@PI
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& ssh-keygen
	if ($lastExitCode -ne 0) { throw "ssh-keygen failed" }

	if (Test-Path "~/.ssh/id_ed25519.pub") {
		$publicKey = Get-Content "~/.ssh/id_ed25519.pub"
		$type = "Ed25519"
	} elseif (Test-Path "~/.ssh/id_rsa.pub") {
		$publicKey = Get-Content "~/.ssh/id_rsa.pub"
		$type = "RSA"
	} else {
		throw "No public key found."
	}
	"✅ Your new SSH key has been saved to ~/.ssh ($type type). The public key is:"
	"   $publicKey"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
