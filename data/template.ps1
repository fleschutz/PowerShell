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
.NOTES
	Author:        ← enter full name here
	License:       ← enter license here
.LINK
	← enter URL here
#>

#requires -version 4

param() # ← enter script parameters here

#	← enter functions here 

try {
#	← enter instructions here 

	"✔️ Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
