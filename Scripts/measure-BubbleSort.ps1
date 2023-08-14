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