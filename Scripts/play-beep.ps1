#!/snap/bin/powershell
<#
.SYNTAX         ./play-beep.ps1
.DESCRIPTION	plays a beep sound
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	[console]::beep(500,300)
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
