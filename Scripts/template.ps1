#requires -version 2
<#
.SYNOPSIS
	← enter overview of script here
.DESCRIPTION
	← enter brief description of script here
.INPUTS
	← enter inputs here (if any, otherwise state None)
.OUTPUTS
	← enter outputs here (if any, otherwise state None)
.EXAMPLE
	PS> .\template.ps1 ← enter example here (repeat this attribute for more than one example)
.LINK
	← enter URL here
.NOTES
	Author:        ← enter full name here
	Creation Date: ← enter date here
	License:       ← enter license here
#>

param() # ← enter file parameter(s) here

#	← enter function(s) here 

try {
#	← enter instructions here 

	"✔️ Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
