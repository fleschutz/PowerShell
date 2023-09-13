<#
.SYNOPSIS
        Measures the speed of InsertionSort
.DESCRIPTION
        This PowerShell script measures the speed of the InsertionSort algorithm.
        InsertionSort is a simple sorting algorithm that builds the final sorted array (or list)
	one item at a time. It is much less efficient on large lists than more advanced algorithms
	such as quicksort, heapsort, or merge sort.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-InsertionSort.ps1
	🧭 Sorting of 1000 integers by InsertionSort took 0.4234268 sec
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class InsertionSort {
    static Sort($targetList) {
        $n = $targetList.count

        for ($i = 0; $i -lt $n - 1; $i++) {
            $j = $i + 1

            while ($j -gt 0) {

                if ($targetList[$j - 1] -gt $targetList[$j]) {
                    $temp = $targetList[$j - 1]
                    $targetList[$j - 1] = $targetList[$j]
                    $targetList[$j] = $temp
                }

                $j--
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[InsertionSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🧭 Sorting of $numIntegers integers by InsertionSort took $elapsed sec"
exit 0 # success
