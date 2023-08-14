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
"🕒 QuickSort of $numIntegers integers took $elapsed sec"
exit 0 # success