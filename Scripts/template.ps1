<#
.SYNOPSIS
	template.ps1 
.DESCRIPTION
	Copy this template PowerShell script to write a new one
.EXAMPLE
	PS> .\template.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param() # <- enter file parameter(s) here

#	<- enter function(s) here 

try {
#	<- enter workload here 

	"✔️ Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
