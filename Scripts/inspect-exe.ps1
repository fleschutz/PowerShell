#!/snap/bin/powershell

# Syntax:	./inspect-exe.ps1 [<executable-file>]
# Description:	prints basic information of the given executable file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$File)

try {
	if ($File -eq "" ) {
		$File = read-host "Enter path to executable file"
	}
	get-childitem $File | % {$_.VersionInfo} | Select *
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
