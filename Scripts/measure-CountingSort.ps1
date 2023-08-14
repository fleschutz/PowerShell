param([int]$numIntegers = 1000)

class CountingSort {
    static Sort($targetList) {
        $min = 0
        $max = 0

        for ($counter = 0; $counter -lt $targetList.Count; $counter++) {
            if ($targetList[$counter] -lt $min) { $min = $targetList[$counter] }
            if ($targetList[$counter] -gt $max) { $max = $targetList[$counter] }
        }

        $arrayBucket = New-Object int[] ($max - $min + 1)

        for ($counter = 0; $counter -lt $targetList.Count; $counter++) {
            $arrayBucket[$targetList[$counter]]++;
        }

        $lastPosition = 0
        for ($counter = 0; $counter -lt $arrayBucket.Count ; $counter++) {
            for ($innerCounter = 0; $innerCounter -lt $arrayBucket[$counter]; $innerCounter++) {
                $targetList[$lastPosition++] = $counter
            }
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[CountingSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🕒 CountingSort of $numIntegers integers took $elapsed sec"
exit 0 # success