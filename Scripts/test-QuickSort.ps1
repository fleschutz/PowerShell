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

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$list = (1..1000 | ForEach{Get-Random -Minimum 1 -Maximum 1000})
[QuickSort]::Sort($list, 0, $list.Count-1)
[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds
"🕒 QuickSort of 1000 integers took $Elapsed sec"
