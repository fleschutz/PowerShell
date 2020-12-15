#!/snap/bin/powershell

# Syntax:       ./simulate-matrix.ps1 
# Description:	simulates the Matrix (fun)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	$PathToData=(get-item $MyInvocation.MyCommand.Path).directory
	$PathToData="$PathToData/../Data"
	$Table = import-csv "$PathToData/Matrix.csv"

	Clear-Host
	foreach($Row in $Table) {
		for ($i = 0; $i -lt 4; $i++) {
			Write-Host -nonewline $($Row.A); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.B); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.C); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.D); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.E); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.F); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.G); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.H); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.I); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.J); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.K); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.L); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.M); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.N); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.O); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.P); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.Q); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.R); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.S); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.T); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.U); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.V); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.W); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.X); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.Y); Start-Sleep -milliseconds 5
			Write-Host -nonewline $($Row.Z); Start-Sleep -milliseconds 5
		}
		Write-Host ""
	    	Start-Sleep -milliseconds 200
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
