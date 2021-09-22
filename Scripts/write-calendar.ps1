<#
.SYNOPSIS
	Writes out calendar elements, either a single month or an entire year depending on the inputs.
.PARAMETER Month
	If specified, will limit output to a single month with this numeral value.
.PARAMETER Year
	If specified, will output an entire year.
.PARAMETER $DateColors
	A [ConsoleColor] array of two elements specifying the foreground color and background color for each day printed
.PARAMETER $TodayColors
	A [ConsoleColor] array of two elements specifying the foreground color and background color for today's date
.PARAMETER $HolidayColors
	A [ConsoleColor] array of two elements specifying the foreground color and background color for holidays printed
.NOTES
	This script has some functionality which many would consider weird or inconsistent. Specifically, if a month is specifed and a year is not, then the output is typically the calendar for the input month and the current year. However, if the specified month is greater than 12, then it's treated as a year and the whole year is outputted.
The reason for this is to emulate the *NIX cal function, which behaves similarly. That is, cal outputs the current month, cal 2012 outpus the calendar for 2012 and cal 05 2012 outputs the calendar for May 2012.
That is pretty much how Write-Calendar works with the exception that Write-Calendar 05 will write out the calendar for May of the current year whereas cal will output the calendar for the year 5.
Since the point of this script is to emulate cal's functionality I will probably not change it to make it more consistent.
.EXAMPLE
	Write-Calendar
	Outputs the current month.
.EXAMPLE
	Write-Calendar 2013
	Outputs the calendar for 2013.
.EXAMPLE
	Write-Calendar 04 2011
	Outputs the calendar for April, 2011.
.EXAMPLE
	Write-Calendar 7
	Outputs the calendar for September of this year.
#>

param (
    [int] $Month = (Get-Date).Month,
    [int] $Year = (Get-Date).Year,
    [ConsoleColor[]] $DateColors = @([ConsoleColor]::White, [Console]::BackgroundColor),
    [ConsoleColor[]] $TodayColors = @([ConsoleColor]::Red, [Console]::BackgroundColor),
    [ConsoleColor[]] $HolidayColors = @([ConsoleColor]::White, [ConsoleColor]::DarkCyan)
)

Set-Variable -name daysLine -option Constant -value "Su Mo Tu We Th Fr Sa "

if ($year -lt 0) { throw "Year parameter must be greater than 0" }
if ($month -lt 0) { throw "Month parameter must be between 1 and 12" }

if (($month -gt 12) -and ($year -eq (Get-Date).Year)) {
    $year = $month
    $month = 0
}
elseif (($month -gt 12) -and ($year -ne (Get-Date).Year)) {
    throw "Month parameter must be between 1 and 12"
}

foreach ($array in @($DateColors, $TodayColors, $HolidayColors)) {
    if ($array.Length -lt 2) {
        throw "Must specify both foreground and background colors for color parameters"
    }
}

function Print-Month ($month, $year) {
    $firstDayOfMonth = Get-Date -month $month -day 1 -year $year
    $lastDayOfMonth = (Get-Date -month $firstDayOfMonth.AddMonths(1).Month -day 1 -year $firstDayOfMonth.AddMonths(1).Year).AddDays(-1)
    
    $header = (Get-Date $firstDayOfMonth -Format MMMM) + " " + $firstDayOfMonth.Year
    Write-Host
    Write-Host ((" " * (($daysLine.Length - $header.Length) / 2)) + $header)
    Write-Host $daysLine
    
    for ($day = $firstDayOfMonth; $day -le $lastDayOfMonth; $day = $day.AddDays(1)) {
        $ForegroundColor = $DateColors[0]
        $BackgroundColor = $DateColors[1]
        
        if ($day.date -eq (get-date).date) {
            $ForegroundColor = $TodayColors[0]
            $BackgroundColor = $TodayColors[1]
        }
        
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

function Print-Year ($year) {

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
            $ForegroundColor = $DateColors[0]
            $BackgroundColor = $DateColors[1]
            
            if ($dayOfMonth -eq 1) {
                Write-Host (" " * 3 * $dayOffSet) -NoNewLine
            }
                
            if ($dayOfMonth -le (Get-Date -day 1 -month ((($i + $month) % 12) + 1) -year $year).AddDays(-1).day) {
                $currentDay = (Get-Date -day $dayOfMonth -month ((($i + $month - 1) % 12) + 1) -year $year)

                if ($currentDay.date -eq (Get-Date).date) {
                    $ForegroundColor = $TodayColors[0]
                    $BackgroundColor = $TodayColors[1]
                }
                
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

function Get-Holidays ($year) {
    $holidays = @(
        Get-Date -Year $year -Month 1 -Day 1 # New Year's Day
        Find-WeekDayMultiple $year 1 "Monday" 3 # MLK Day
        Find-WeekDayMultiple $year 2 "Monday" 3 # President's Day
        Find-GoodFriday $year # Good Friday
        Find-LastWeekDay $year 5 "Monday" # Memorial Day
        Get-Date -Year $year -Month 7 -Day 4 # Fourth of July
        Find-WeekDayMultiple $year 9 "Monday" 1 # Labor Day
        Find-WeekDayMultiple $year 10 "Monday" 2 # Columbus Day
        Get-Date -Year $year -Month 11 -Day 11 # Veterans Day
        Find-WeekDayMultiple $year 11 "Thursday" 4 # Thanksgiving
        Get-Date -Year $year -Month 12 -Day 25 # Christmas
    ) |% {$_.Date}

    return $holidays
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

function Find-GoodFriday ($year) {
    # Taken from http://en.wikipedia.org/wiki/Computus#Anonymous_Gregorian_algorithm
    $a = $year % 19
    $b = [Math]::Floor($year / 100)
    $c = $year % 100
    $d = [Math]::Floor($b / 4)
    $e = $b % 4
    $f = [Math]::Floor(($b + 8) / 25)
    $g = [Math]::Floor(($b - $f + 1) / 3)
    $h = (19 * $a + $b - $d - $g + 15) % 30
    $i = [Math]::Floor($c / 4)
    $k = $c % 4
    $L = (32 + 2 * $e + 2 * $i - $h - $k) % 7
    $m = [Math]::Floor(($a + 11 * $h + 22 * $L) / 451)
    $month = [Math]::Floor(($h + $L - 7 * $m + 114) / 31)
    $day = (($h + $L - 7 * $m + 114) % 31) + 1
    return (Get-Date -Year $year -Month $month -Day $day).AddDays(-2)
}

if ($month -ne 0) {
    Print-Month $month $year
}
else {
    Print-Year $year
}
