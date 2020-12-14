#!/snap/bin/powershell

# Syntax:       ./matrix-effect.ps1 
# Description:	shows the Matrix effect
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	$PathToData=(get-item $MyInvocation.MyCommand.Path).directory
	$PathToData="$PathToData/../Data"
	$Table = import-csv "$PathToData/Matrix.csv"

	Clear-Host
	foreach($Row in $Table) {
		Write-Host -nonewline $($Row.A)
	    	Start-Sleep -milliseconds 10
		Write-Host -nonewline $($Row.B)
	    	Start-Sleep -milliseconds 10
		Write-Host -nonewline $($Row.C)
	    	Start-Sleep -milliseconds 10
		Write-Host -nonewline $($Row.D)
	    	Start-Sleep -milliseconds 10
		Write-Host -nonewline $($Row.E)
	    	Start-Sleep -milliseconds 10
		Write-Host -nonewline $($Row.F)
	    	Start-Sleep -milliseconds 10
		Write-Host $($Row.G)
	    	Start-Sleep -milliseconds 200
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
