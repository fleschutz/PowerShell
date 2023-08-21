<#
.SYNOPSIS
        Measures the BubbleSort algorithm
.DESCRIPTION
        This PowerShell script measures the speed of the BubbleSort algorithm.
	BubbleSort is a simple sorting algorithm that repeatedly steps through the list,
	compares adjacent elements and swaps them if they are in the wrong order. The pass
	through the list is repeated until the list is sorted. The algorithm, which is a
	comparison sort, is named for the way smaller or larger elements "bubble" to the top of the list.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-bubblesort.ps1
	🕒 BubbleSort of 1000 integers took 0.7291663 sec
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class BubbleSort {
    static Sort($targetList) {
        $n = $targetList.Count

        for ($i = 0; $i -lt $n; $i+=1) {
            for ($j = 0; $j -lt $n-1; $j+=1) {
                if($targetList[$j] -gt $targetList[$j+1]) {
                    $temp = $targetList[$j+1]
                    $targetList[$j+1]=$targetList[$j]
                    $targetList[$j]=$temp
                }
            }
        }
    }
}

$list = (1..$NumIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[BubbleSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🕒 BubbleSort of $numIntegers integers took $elapsed sec"
exit 0 # success