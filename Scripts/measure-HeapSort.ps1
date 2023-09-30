<#
.SYNOPSIS
        Measures the speed of HeapSort
.DESCRIPTION
        This PowerShell script measures the speed of the HeapSort algorithm.
        HeapSort is a comparison-based sorting algorithm. Heapsort can be thought of as an
	improved selection sort: like selection sort, heapsort divides its input into a sorted
	and an unsorted region, and it iteratively shrinks the unsorted region by extracting
	the largest element from it and inserting it into the sorted region. Unlike selection
	sort, heapsort does not waste time with a linear-time scan of the unsorted region;
	rather, heap sort maintains the unsorted region in a heap data structure to more quickly
	find the largest element in each step.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-HeapSort.ps1
        🧭 0.614 sec to sort 1000 integers by HeapSort 
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class HeapSort {
    static Sort($targetList) {
        $heapSize = $targetList.Count

        for ([int]$p = ($heapSize - 1) / 2; $p -ge 0; $p--) {
            [HeapSort]::MaxHeapify($targetList, $heapSize, $p)
        }

        for ($i = $targetList.Count - 1; $i -gt 0; $i--) {
            $temp = $targetList[$i]
            $targetList[$i] = $targetList[0]
            $targetList[0] = $temp

            $heapSize--
            [HeapSort]::MaxHeapify($targetList, $heapSize, 0)
        }
    }

    static MaxHeapify($targetList, $heapSize, $index) {
        $left = ($index + 1) * 2 - 1
        $right = ($index + 1) * 2
        $largest = 0

        if ($left -lt $heapSize -and $targetList[$left] -gt $targetList[$index]) {
            $largest = $left
        }
        else {
            $largest = $index
        }

        if ($right -lt $heapSize -and $targetList[$right] -gt $targetList[$largest]) {
            $largest = $right
        }

        if ($largest -ne $index) {
            $temp = $targetList[$index]
            $targetList[$index] = $targetList[$largest]
            $targetList[$largest] = $temp

            [HeapSort]::MaxHeapify($targetList, $heapSize, $largest)
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[HeapSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by HeapSort"
exit 0 # success
