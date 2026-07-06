<#
.SYNOPSIS
	Lists fixed disk partitions.
.DESCRIPTION
	Lists all fixed disk partitions, sorts them first by disk number, then partition number, and adds an
	index column that assigns the smallest unused natural number to each partition.
.EXAMPLE
	PS C:\> & '.\list-partitions.ps1'

Index DiskNumber PartitionNumber          Size AccessPaths
----- ---------- ---------------          ---- -----------
    1          0               1     104857600 {\\?\Volume{34e03429-954c-11e7-ab29-96e5d74c0547}\}
    2          0               2      16777216
    3          0               3  107374182400 {C:\, \\?\Volume{34e03428-954c-11e7-ab29-96e5d74c0547}\}
    4          0               4    1073741824 {\\?\Volume{e9066cf1-a410-4a8b-a5ca-e14405115dc7}\}
    5          0               5   71475134464 {D:\, \\?\Volume{34e0342a-954c-11e7-ab29-96e5d74c0547}\}
    6          1               1 1000196800512 {E:\, \\?\Volume{0001ab51-1d10-024a-ef07-d901a2560300}\}
    7          1               2 1000197849088 {G:\, \\?\Volume{0001ae53-9b30-02bf-ef4f-f975a65c0300}\}
    8          2               1  500106780672 {F:\, \\?\Volume{032d0340-07ef-01d9-8081-9681f783ec00}\}
    9          3               1      16759808
   10          3               2  165343657984 {W:\, \\?\Volume{012cec3e-7375-4f45-958b-304c1a5e66bc}\}
.PARAMETER EmitObject
	Instead of outputting a human-readable table intended for visual perusal, the script emits a machine
	readable array of objects with "Index", "DiskNumber", "PartitionNumber", "Size", and "AccessPaths"
	properties.
#>

#requires -version 5.1

using namespace System.Management.Automation

[CmdletBinding()]
param(
  [Switch][Alias("PassThru")]$EmitObject = $false
)

# List partitions and sort them by disk number and partition number
$PartitionList = Get-Partition | Sort-Object -Property DiskNumber, PartitionNumber

# Index partitions
$i = 0
$PartitionList | ForEach-Object {
  $i++
  $PSItem | Add-Member -NotePropertyName Index -NotePropertyValue $i
}

# Produce output
$OutputCmdletParams = @{
  Property = "Index", "DiskNumber", "PartitionNumber", "Size", "AccessPaths"
}
if ($EmitObject) {
  $PartitionList | Select-Object @OutputCmdletParams
} else {
  $PartitionList | Format-Table @OutputCmdletParams -AutoSize
}
