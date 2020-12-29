#!/snap/bin/powershell
<#
.SYNTAX         ./test.ps1
.DESCRIPTION	simple PowerShell test script
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	write-output "✔️ PowerShell works. Details are:"
	echo $PSVersionTable
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
