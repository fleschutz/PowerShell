<#
.SYNOPSIS
	Measures the speed of BubbleSort 
.DESCRIPTION
	This PowerShell script measures the speed of the BubbleSort algorithm.
	BubbleSort is a simple sorting algorithm that repeatedly steps through the list,
	compares adjacent elements and swaps them if they are in the wrong order. The pass
	through the list is repeated until the list is sorted. The algorithm, which is a
	comparison sort, is named for the way smaller or larger elements "bubble" to the top of the list.
.PARAMETER numIntegers
	Specifies the number of integers to sort
.EXAMPLE
	PS> ./measure-BubbleSort.ps1
	🧭 0.729 sec to sort 1000 integers by BubbleSort 
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
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by BubbleSort"
exit 0 # success
