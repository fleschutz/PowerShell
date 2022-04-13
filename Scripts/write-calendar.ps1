<#
.SYNOPSIS
	Writes out a calendar 
.DESCRIPTION
	Writes out calendar elements, either a single month or an entire year.
.PARAMETER Month
	If specified, will limit output to a single month with this numeral value.
.PARAMETER Year
	If specified, will output an entire year.
.EXAMPLE
	PS> ./write-calendar
	Outputs the current month.
.EXAMPLE
	PS> ./write-calendar 2013
	Outputs the calendar for 2013.
.EXAMPLE
	PS> ./write-calendar 04 2011
	Outputs the calendar for April, 2011.
.EXAMPLE
	PS> ./write-calendar 7
	Outputs the calendar for July of this year.
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]$Month = (Get-Date).Month, [int]$Year = (Get-Date).Year)

function Print-Month ($month, $year) {
    $firstDayOfMonth = Get-Date -month $month -day 1 -year $year
    $lastDayOfMonth = (Get-Date -month $firstDayOfMonth.AddMonths(1).Month -day 1 -year $firstDayOfMonth.AddMonths(1).Year).AddDays(-1)
    
    $header = (Get-Date $firstDayOfMonth -Format MMMM) + " " + $firstDayOfMonth.Year
    Write-Host
    Write-Host ((" " * (($daysLine.Length - $header.Length) / 2)) + $header)
    Write-Host $daysLine
    
    for ($day = $firstDayOfMonth; $day -le $lastDayOfMonth; $day = $day.AddDays(1)) {
        if ($day.day -eq 1) {
            Write-Host (" " * 3 * [int](Get-Date $day -uformat %u)) -NoNewLine
        }
        
        Write-Host ((Get-Date $day -Format dd).ToString()) -NoNewLine 
        Write-Host " " -NoNewLine
        
        if ($day.DayOfWeek -eq "Saturday") {
            Write-Host
        }
    }
    
    if ($lastDayOfMonth.DayOfWeek -ne "Saturday") {
        Write-Host
    }

    Write-Host
}

function Print-Year($year) {

    Write-Host
    
    for($month = 1; $month -le 12; $month += 3) {
        $header = ""
        
        for ($i = $month; $i -lt $month + 3; $i++) {
            $tempHeader = (Get-Date -month $i -Format MMMM) + " " + $year.ToString()
            $header += ((" " * (($daysLine.Length - $tempHeader.Length) / 2)) + $tempHeader + (" " * (($daysLine.Length - $tempHeader.Length) / 2)))
            $header += "  "
        }
        
        Write-Host $header
        Write-Host (($daysLine + "  ") * 3)
        
        $dayCounts = (1, 1, 1)
        $i = 0

        while ($dayCounts[0] -le (Get-Date -day 1 -month ($month + 1) -year $year).AddDays(-1).day -or `
               $dayCounts[1] -le (Get-Date -day 1 -month ($month + 2) -year $year).AddDays(-1).day -or `
               $dayCounts[2] -le (Get-Date -day 1 -month (($month + 3) % 12) -year $year).AddDays(-1).day) {

            $dayOfMonth = $dayCounts[$i]
            $dayCounts[$i]++
            $dayOffset = [int](Get-Date -day 1 -month ($month + $i) -year $year -uformat %u)
            
            if ($dayOfMonth -eq 1) {
                Write-Host (" " * 3 * $dayOffSet) -NoNewLine
            }
                
            if ($dayOfMonth -le (Get-Date -day 1 -month ((($i + $month) % 12) + 1) -year $year).AddDays(-1).day) {
                $currentDay = (Get-Date -day $dayOfMonth -month ((($i + $month - 1) % 12) + 1) -year $year)

                Write-Host ((Get-Date -month ($i + $month) -day $dayOfMonth -year $year -Format dd).ToString()) -NoNewLine 
                Write-Host " " -NoNewLine
            }
            else {
                Write-Host "   " -NoNewLine
            }
            
            if ((($dayOfMonth + $dayOffset) % 7) -eq 0) {
                $i = ($i + 1) % 3
                Write-Host "  " -NoNewLine
                
                if ($i -eq 0) {
                    Write-Host
                }
            }
        }
        
        Write-Host
        $dayCounts = (1, 1, 1)
    }
}

function Find-WeekDayMultiple ($year, $month, $dayOfWeek, $multiple) {
    $result = Get-Date -Year $year -Month $month -Day 1
    $multipleCount = 0

    do {
        if ($result.DayOfWeek -eq $dayOfWeek) {
            $multipleCount++
        }

        $result = $result.AddDays(1)

        if ($result.Month -ne $month) {
            throw "Could not find weekday multiple."
        }
    }
    while ($multipleCount -lt $multiple)

    return $result.AddDays(-1)
}

function Find-LastWeekDay ($year, $month, $dayOfWeek) {
    $result = $dayCounter = Get-Date -Year $year -Month $month -Day 1

    while ($dayCounter.Month -eq $month) {
        if ($dayCounter.DayOfWeek -eq $dayOfWeek) {
            $result = $dayCounter
        }

        $dayCounter = $dayCounter.AddDays(1)
    }

    return $result
}

try {
	Set-Variable -name daysLine -option Constant -value "Su Mo Tu We Th Fr Sa "

	if ($year -lt 0) { throw "Year parameter must be greater than 0" }
	if ($month -lt 0) { throw "Month parameter must be between 1 and 12" }

	if (($month -gt 12) -and ($year -eq (Get-Date).Year)) {
	    $year = $month
	    $month = 0
	} elseif (($month -gt 12) -and ($year -ne (Get-Date).Year)) {
	    throw "Month parameter must be between 1 and 12"
	}
	if ($month -ne 0) {
	    Print-Month $month $year
	} else {
	    Print-Year $year
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
