param([int]$numIntegers = 1000)

class InsertionSort {
    static Sort($targetList) {
        $n = $targetList.count

        for ($i = 0; $i -lt $n - 1; $i++) {
            $j = $i + 1

            while ($j -gt 0) {

                if ($targetList[$j - 1] -gt $targetList[$j]) {
                    $temp = $targetList[$j - 1]
                    $targetList[$j - 1] = $targetList[$j]
                    $targetList[$j] = $temp
                }

                $j--
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[InsertionSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🕒 InsertionSort of $numIntegers integers took $elapsed sec"
exit 0 # success