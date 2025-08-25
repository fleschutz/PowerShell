﻿<#
.SYNOPSIS
        Lists the public SSH key
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
	} elseif (Test-Path "~/.ssh/id_rsa.pub") {
		$key = Get-Content "~/.ssh/id_rsa.pub"	
	} else {
		"⚠️ No SSH key found - execute 'new-ssh-key.ps1' to create one"
		exit 1
	}
	"✅ Public SSH key: $key"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
