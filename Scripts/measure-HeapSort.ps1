param([int]$numIntegers = 1000)

class HeapSort {
    static Sort($targetList) {
        $heapSize = $targetList.Count

        for ([int]$p = ($heapSize - 1) / 2; $p -ge 0; $p--) {
            [HeapSort]::MaxHeapify($targetList, $heapSize, $p)
        }

        for ($i = $targetList.Count - 1; $i -gt 0; $i--) {
            $temp = $targetList[$i]
            $targetList[$i] = $targetList[0]
            $targetList[0] = $temp

            $heapSize--
            [HeapSort]::MaxHeapify($targetList, $heapSize, 0)
        }
    }

    static MaxHeapify($targetList, $heapSize, $index) {
        $left = ($index + 1) * 2 - 1
        $right = ($index + 1) * 2
        $largest = 0

        if ($left -lt $heapSize -and $targetList[$left] -gt $targetList[$index]) {
            $largest = $left
        }
        else {
            $largest = $index
        }

        if ($right -lt $heapSize -and $targetList[$right] -gt $targetList[$largest]) {
            $largest = $right
        }

        if ($largest -ne $index) {
            $temp = $targetList[$index]
            $targetList[$index] = $targetList[$largest]
            $targetList[$largest] = $temp

            [HeapSort]::MaxHeapify($targetList, $heapSize, $largest)
        }
    }
}

$list = (1..$numIntegers | foreach{Get-Random -minimum 1 -maximum $numIntegers})
$stopWatch = [system.diagnostics.stopwatch]::startNew()
[HeapSort]::Sort($list)
[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
"🕒 HeapSort of $numIntegers integers took $elapsed sec"
exit 0 # success