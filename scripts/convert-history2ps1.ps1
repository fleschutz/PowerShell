<#
.SYNOPSIS
        Converts history to PowerShell script
.DESCRIPTION
        This PowerShell script converts your command history into a PowerShell script.
	It saves all your commands into a script for automation (executed by e.g Jenkins or AutoHotkey).
.PARAMETER path
        Specifies the file path of the new script ('script-from-history.ps1' by default)
.EXAMPLE
        PS> ./convert-history2ps1.ps1
	✅ Converted your command history into the PowerShell script: script-from-history.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "script-from-history.ps1")

try {
	$history = Get-History

	foreach ($item in $history) {
		Write-Output "`"⏳ Step #$($item.Id): Executing $($item.CommandLine) ...`"" >> $path
		Write-Output "& $($item.CommandLine)" >> $path
		Write-Output "" >> $path
	}
	Write-Output "`"✅ PowerShell script finished (source: command history of $($env:USERNAME) on $($env:COMPUTERNAME)).`"" >> $path
	Write-Output "exit 0 # success" >> $path
	"✅ Converted your command history into PowerShell script: $path"
        exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
