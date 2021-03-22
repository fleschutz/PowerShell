#!/bin/powershell
<#
.SYNTAX         ./enable-god-mode.ps1 
.DESCRIPTION	enables the god mode (adds a new icon to the desktop)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	$godmodeSplat = @{
		Path = "$env:USERPROFILEDesktop"
		Name = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		ItemType = 'Directory'
	}
	new-item @godmodeSplat

	write-host -foregroundColor green "OK - see the new desktop icon"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
