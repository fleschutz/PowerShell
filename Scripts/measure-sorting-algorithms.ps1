<#
.SYNOPSIS
	Measures the speed of sorting algorithms
.DESCRIPTION
	This PowerShell script measures the speed of several sorting algorithms and prints it.
.PARAMETER numIntegers
	Specifies the number of integers to sort (3000 by default)
.EXAMPLE
	PS> ./measure-sorting-algorithms.ps1
	🧭 6.041 sec to sort 3000 integers by BubbleSort
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$numIntegers = 3000)

" "
& "$PSScriptRoot/measure-BubbleSort.ps1" $numIntegers
& "$PSScriptRoot/measure-BucketSort.ps1" $numIntegers
& "$PSScriptRoot/measure-CountingSort.ps1" $numIntegers
& "$PSScriptRoot/measure-HeapSort.ps1" $numIntegers
& "$PSScriptRoot/measure-InsertionSort.ps1" $numIntegers
& "$PSScriptRoot/measure-MergeSort.ps1" $numIntegers
& "$PSScriptRoot/measure-QuickSort.ps1" $numIntegers
& "$PSScriptRoot/measure-SelectionSort.ps1" $numIntegers
exit 0 # success
