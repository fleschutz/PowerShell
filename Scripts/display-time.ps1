#!/snap/bin/powershell
<#
.SYNTAX         ./display-time.ps1 
.DESCRIPTION	displays the current time
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	for ($i = 0; $i -lt 1000; $i++) {
		$CurrentTime = Get-Date -format "yyyy-MM-dd HH:mm:ss" 
		clear-host
		write-output ""
		./write-big $CurrentTime
		write-output ""
		start-sleep -s 1
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
