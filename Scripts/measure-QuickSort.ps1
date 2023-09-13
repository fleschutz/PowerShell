<#
.SYNOPSIS
        Measures the speed of QuickSort
.DESCRIPTION
        This PowerShell script measures the speed of the QuickSort algorithm.
        QuickSort is an in-place sorting algorithm. Developed by British computer scientist
	Tony Hoare in 1959 and published in 1961, it is still a commonly used algorithm for
	sorting. When implemented well, it can be somewhat faster than merge sort and about
	two or three times faster than heapsort.
.PARAMETER numIntegers
        Specifies the number of integers to sort
.EXAMPLE
        PS> ./measure-QuickSort.ps1
 	🧭 0.085 sec to sort 1000 integers by QuickSort 
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 1000)

class QuickSort {
    static Sort($targetList, $left, $right) {
        $i=$left
        $j=$right
        $pivot = $targetList[($left+$right)/2]

        while($i -le $j) {
            while($targetList[$i] -lt $pivot -and $i -lt $right) {$i++}
            while($targetList[$j] -gt $pivot -and $j -gt $left) {$j--}

            if($i -le $j) {
                $tmp = $targetList[$i]
                $targetList[$i]=$targetList[$j]
                $targetList[$j]=$tmp

                $i++
                $j--
            }
        }

        if($left -lt $j) {[QuickSort]::Sort($targetList, $left, $j)}
        if($i -lt $right) {[QuickSort]::Sort($targetList, $i, $right)}
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[QuickSort]::Sort($list, 0, $list.Count-1)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
$elapsed3 = "{0:N3}" -f $elapsed # formatted to 3 decimal places
"🧭 $elapsed3 sec to sort $numIntegers integers by QuickSort"
exit 0 # success
