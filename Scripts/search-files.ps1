#!/snap/bin/powershell

# Syntax:       ./search-files.ps1 [<pattern>] [<path>]
# Description:	searches the given pattern in the given files
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Pattern, [String]$Path)

Set-StrictMode -Version Latest

try {
	if ($Pattern -eq "" ) {
		$Pattern = read-host "Enter search pattern"
	}
	if ($Path -eq "" ) {
		$Path = read-host "Enter path to files"
	}

	$List = Select-String -Path $Path -Pattern "$Pattern" 
	foreach ($Item in $List) {
		write-output "$($Item.Path) @$($Item.LineNumber)`t$($Item.Line)"
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
