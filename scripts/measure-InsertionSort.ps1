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
	🧭 0.423 sec to sort 1000 integers by InsertionSort 
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
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by InsertionSort"
exit 0 # success
