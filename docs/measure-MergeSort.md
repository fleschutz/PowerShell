The *measure-MergeSort.ps1* Script
===========================

This PowerShell script measures the speed of the MergeSort algorithm.
MergeSort is an efficient, general-purpose, and comparison-based sorting algorithm.
Most implementations produce a stable sort, which means that the order of equal elements
is the same in the input and output. Merge sort is a divide-and-conquer algorithm that
was invented by John von Neumann in 1945. A detailed description and analysis of bottom-up
merge sort appeared in a report by Goldstine and von Neumann as early as 1948.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/measure-MergeSort.ps1 [[-numIntegers] <Int32>] [<CommonParameters>]

-numIntegers <Int32>
    Specifies the number of integers to sort
    
    Required?                    false
    Position?                    1
    Default value                1000
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
PS> ./measure-MergeSort.ps1
🧭 0.378 sec to sorting 1000 integers by MergeSort

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
        Measures the speed of MergeSort
.DESCRIPTION
        This PowerShell script measures the speed of the MergeSort algorithm.
        MergeSort is an efficient, general-purpose, and comparison-based sorting algorithm.
	Most implementations produce a stable sort, which means that the order of equal elements
	is the same in the input and output. Merge sort is a divide-and-conquer algorithm that
	was invented by John von Neumann in 1945. A detailed description and analysis of bottom-up
	merge sort appeared in a report by Goldstine and von Neumann as early as 1948.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-MergeSort.ps1
	🧭 0.378 sec to sorting 1000 integers by MergeSort
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class MergeSort {

    static Merge($theArray, $tempArray, $leftPos, $rightPos, $rightEnd) {
        $leftEnd = $rightPos - 1
        $tmpPos = $leftPos
        $numElements = $rightEnd - $leftPos + 1

        while (($leftPos -le $leftEnd) -and ($rightPos -le $rightEnd)) {
            if ($theArray[$leftPos].CompareTo($theArray[$rightPos]) -le 0) {
                $tempArray[$tmpPos++] = $theArray[$leftPos++]
            }
            else {
                $tempArray[$tmpPos++] = $theArray[$rightPos++]
            }
        }

        while ($leftPos -le $leftEnd) { $tempArray[$tmpPos++] = $theArray[$leftPos++] }
        while ($rightPos -le $rightEnd) { $tempArray[$tmpPos++] = $theArray[$rightPos++] }

        for ($i = 0; $i -lt $numElements; $i++, $rightEnd--) {
            $theArray[$rightEnd] = $tempArray[$rightEnd]
        }
    }

    static Sort($theArray) {
        $tempArray = New-Object Object[] $theArray.Count
        [MergeSort]::Sort($theArray, $tempArray, 0, ($theArray.Count - 1))
    }

    static Sort($theArray, $tempArray, $left, $right) {
        if ($left -lt $right) {

            $center = [Math]::Floor(($left + $right) / 2)

            [MergeSort]::Sort($theArray, $tempArray, $left, $center)
            [MergeSort]::Sort($theArray, $tempArray, ($center + 1), $right)

            [MergeSort]::Merge($theArray, $tempArray, $left, ($center + 1), $right)
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[MergeSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by MergeSort"
exit 0 # success
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:38)*
