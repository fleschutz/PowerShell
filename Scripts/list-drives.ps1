<#
.SYNOPSIS
	list-drives.ps1
.DESCRIPTION
	Lists all drives connected to the computer.
.EXAMPLE
	PS> .\list-drives.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,2)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,2)}}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
