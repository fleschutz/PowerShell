<#
.SYNOPSIS
	Lists all drives
.DESCRIPTION
	This PowerShell script lists all local drives as a table.
.EXAMPLE
	PS> ./list-drives

	Name Root Used (GB) Free (GB)
	---- ---- --------- ---------
	C    C:\     6648,1     744,2
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,1)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,1)}}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
