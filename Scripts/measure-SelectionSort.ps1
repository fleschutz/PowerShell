<#
.SYNOPSIS
        Measures the speed of SelectionSort
.DESCRIPTION
        This PowerShell script measures the speed of the SelectionSort algorithm.
        SelectionSort is an in-place comparison sorting algorithm. It has an O(n2) time complexity,
	which makes it inefficient on large lists, and generally performs worse than the similar
	insertion sort. Selection sort is noted for its simplicity and has performance advantages
	over more complicated algorithms in certain situations, particularly where auxiliary memory
	is limited. 
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-SelectionSort.ps1
	🧭 Sorting 1000 integers by SelectionSort took 0.3351773 sec
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class SelectionSort {
    static Sort($targetList) {
        $n = $targetList.count

        for ($i = 0; $i -lt $n; $i++) {
            for ($j = $i + 1; $j -lt $n; $j++) {
                if ($targetList[$j] -lt $targetList[$i]) {
                    $tmp = $targetList[$i]
                    $targetList[$i] = $targetList[$j]
                    $targetList[$j] = $tmp
                }
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[SelectionSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🧭 Sorting $numIntegers integers by SelectionSort took $elapsed sec"
exit 0 # success
