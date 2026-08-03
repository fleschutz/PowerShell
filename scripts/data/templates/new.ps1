<#
.SYNOPSIS
	← enter a brief description of the script here
.DESCRIPTION
	← enter a detailed description of the script here
.PARAMETER
	← enter the description of a parameter here (optional, repeat the .PARAMETER for each parameter)
.EXAMPLE
	← enter a sample command that uses the script, optionally followed by sample output and a description (repeat the .EXAMPLE for each example)
.NOTES
	Author:        ← enter full name here
	License:       ← enter license here
.LINK
	https://       ← enter the URL to additional information here
#>

#requires -version 5.1

param() # ← enter script parameters here

#	← enter functions here 

try {
#	← enter instructions here 

	"✔️ Done."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
