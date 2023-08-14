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

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$list = (1..$NumIntegers | %{Get-Random -Minimum 1 -Maximum 1000})
[BubbleSort]::Sort($list)
[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds
"🕒 BubbleSort of $NumIntegers integers took $Elapsed sec"
