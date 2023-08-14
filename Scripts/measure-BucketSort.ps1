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
"🕒 BucketSort of $numIntegers integers took $elapsed sec"
exit 0 # success