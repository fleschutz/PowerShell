<#
.SYNOPSIS
	Lists all local drives
.DESCRIPTION
	This PowerShell script lists the details of all local drives.
.EXAMPLE
	PS> ./list-drives

	Name Root Used (GB) Free (GB)
	---- ---- --------- ---------
	C    C:\       76,1      35,0
	D    D:\     6648,1     744,2
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,1)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,1)}}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
