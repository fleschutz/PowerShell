<#
.SYNOPSIS
	list-drives.ps1
.DESCRIPTION
	Lists all drives connected to the computer
.EXAMPLE
	PS> ./list-drives

	Name Root Used (GB) Free (GB)
	---- ---- --------- ---------
	C    C:\      76,14     35,05
	D    D:\    6648,12    744,16
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,2)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,2)}}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
