<#
.SYNOPSIS
        Measures the speed of CountingSort
.DESCRIPTION
        This PowerShell script measures the speed of the CountingSort algorithm.
        CountingSort is an algorithm for sorting a collection of objects according to keys
	that are small positive integers; that is, it is an integer sorting algorithm. It
	operates by counting the number of objects that possess distinct key values, and
	applying prefix sum on those counts to determine the positions of each key value in
	the output sequence. Its running time is linear in the number of items and the difference
	between the maximum key value and the minimum key value, so it is only suitable for direct
	use in situations where the variation in keys is not significantly greater than the number
	of items. It is often used as a subroutine in radix sort, another sorting algorithm, which
	can handle larger keys more efficiently.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-CountingSort.ps1
        🧭 0.045 sec to sort 1000 integers by CountingSort 
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class CountingSort {
    static Sort($targetList) {
        $min = 0
        $max = 0

        for ($counter = 0; $counter -lt $targetList.Count; $counter++) {
            if ($targetList[$counter] -lt $min) { $min = $targetList[$counter] }
            if ($targetList[$counter] -gt $max) { $max = $targetList[$counter] }
        }

        $arrayBucket = New-Object int[] ($max - $min + 1)

        for ($counter = 0; $counter -lt $targetList.Count; $counter++) {
            $arrayBucket[$targetList[$counter]]++;
        }

        $lastPosition = 0
        for ($counter = 0; $counter -lt $arrayBucket.Count ; $counter++) {
            for ($innerCounter = 0; $innerCounter -lt $arrayBucket[$counter]; $innerCounter++) {
                $targetList[$lastPosition++] = $counter
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[CountingSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by CountingSort"
exit 0 # success
