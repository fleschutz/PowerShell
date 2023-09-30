<#
.SYNOPSIS
	Measures the speed of BucketSort 
.DESCRIPTION
	This PowerShell script measures the speed of the BucketSort algorithm.
	BucketSort is a sorting algorithm that works by distributing the elements
	of an array into a number of buckets. Each bucket is then sorted individually,
	either using a different sorting algorithm, or by recursively applying the bucket
	sorting algorithm. It is a distribution sort, a generalization of pigeonhole sort
	that allows multiple keys per bucket, and is a cousin of radix sort in the
	most-to-least significant digit flavor. Bucket sort can be implemented with comparisons
	and therefore can also be considered a comparison sort algorithm. The computational
	complexity depends on the algorithm used to sort each bucket, the number of buckets
	to use, and whether the input is uniformly distributed.
.PARAMETER numIntegers
	Specifies the number of integers to sort
.EXAMPLE
	PS> ./measure-BucketSort.ps1
	🧭 0.065 sec to sort 1000 integers by BucketSort 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class BucketSort {
    static Sort($targetList) {

        $max = $targetList[0]
        $min = $targetList[0]

        for ($i = 1; $i -lt $targetList.Count; $i++) {
            if ($targetList[$i] -gt $max) { $max = $targetList[$i] }
            if ($targetList[$i] -lt $min) { $min = $targetList[$i]}
        }

        $holder = New-Object object[][] ($max - $min + 1)

        for ($i = 0; $i -lt $holder.Count; $i++) {
            $holder[$i] = @()
        }

        for ($i = 0; $i -lt $targetList.Count; $i++) {
            $holder[$targetList[$i] - $min]+=$targetList[$i]
        }

        $k = 0

        for ($i = 0; $i -lt $holder.Count; $i++) {
            if ($holder[$i].Count -gt 0) {
                for ($j = 0; $j -lt $holder[$i].Count; $j++) {
                    $targetList[$k] = $holder[$i][$j]
                    $k++
                }
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[BucketSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by BucketSort"
exit 0 # success
