#!/bin/powershell
<#
.SYNTAX         ./go-root.ps1 
.DESCRIPTION	go to the root directory (C: on Windows)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		set-location /
	} else {
		set-location C:
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
