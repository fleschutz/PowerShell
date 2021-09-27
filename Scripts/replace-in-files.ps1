<#
.SYNOPSIS
	replace-in-files.ps1 [<pattern>] [<replacement>] [<files>]
.DESCRIPTION
	Search and replace a pattern in the given files by the replacement
.EXAMPLE
	PS> ./replace-in-files IO "Input Output" C:\Temp\*.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$pattern = "", [string]$replacement = "", [string]$files = "")

function ReplaceInFile { param([string]$FilePath, [string]$Pattern, [string]$Replacement)

    [System.IO.File]::WriteAllText($FilePath,
        ([System.IO.File]::ReadAllText($FilePath) -replace $Pattern, $Replacement)
    )
}

try {
	if ($pattern -eq "" ) { $pattern = read-host "Enter search pattern" }
	if ($replacement -eq "" ) { $replacement = read-host "Enter replacement" }
	if ($files -eq "" ) { $files = read-host "Enter files" }

	foreach($file in $files) {
		ReplaceInFile $file $pattern $replacement
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
