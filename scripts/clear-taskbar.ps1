<#
.SYNOPSIS
	Clear the taskbar
.DESCRIPTION
	This PowerShell script clears the taskbar on the local computer
.EXAMPLE
	PS> ./clear-taskbar.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function Unpin-App([string]$appname) {
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt()}
}

Unpin-App("Microsoft Edge")
Unpin-App("Microsoft Store")
"✅ Taskbar cleared."
exit 0 # success
