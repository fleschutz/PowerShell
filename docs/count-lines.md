The *count-lines.ps1* Script
===========================

This PowerShell script counts the number of lines in text files (.txt/.md/.c/.h/.cpp/.hpp/.java/.py/.ps1/.bat) within a directory tree.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/count-lines.ps1 [[-pathToDirTree] <String>] [<CommonParameters>]

-pathToDirTree <String>
    Specifies the path to the directory tree.
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./count-lines.ps1 C:\Repos\cmake
✅ Found 639921 lines in 11411 text files within 📂cmake in 34 sec.

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Counts the number of lines 
.DESCRIPTION
	This PowerShell script counts the number of lines in text files (.txt/.md/.c/.h/.cpp/.hpp/.java/.py/.ps1/.bat) within a directory tree.
.PARAMETER pathToDirTree
	Specifies the path to the directory tree.
.EXAMPLE
	PS> ./count-lines.ps1 C:\Repos\cmake
	✅ Found 639921 lines in 11411 text files within 📂cmake in 34 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToDirTree = "")

try {
	if ($pathToDirTree -eq "" ) { $pathToDirTree = Read-Host "Enter the path to the directory tree" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$pathToDirTree = Resolve-Path "$pathToDirTree"
	Write-Progress "Counting lines within $pathToDirTree ..."

	[int64]$numFiles = [int64]$numLines = 0
	Get-ChildItem -Path $pathToDirTree -Include *.txt,*.md,*.c,*.h,*.cpp,*.hpp,*.java,*.py,*.ps1,*.bat -Recurse | ForEach-Object {
		$numLines += (Get-Content $_.FullName | Measure-Object -line).Lines
		$numFiles++
	}

	$folderName = (Get-Item "$pathToDirTree").Name
	Write-Progress -completed " "
	[int]$Elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $numLines lines in $numFiles text files within 📂$folderName in $Elapsed sec." 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:36)*
