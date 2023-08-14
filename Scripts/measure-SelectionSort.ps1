class SelectionSort {
    static Sort($targetList) {
        $n = $targetList.count

        for ($i = 0; $i -lt $n; $i++) {
            for ($j = $i + 1; $j -lt $n; $j++) {
                if ($targetList[$j] -lt $targetList[$i]) {
                    $tmp = $targetList[$i]
                    $targetList[$i] = $targetList[$j]
                    $targetList[$j] = $tmp
                }
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[SelectionSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🕒 SelectionSort of $numIntegers integers took $elapsed sec"
exit 0 # success