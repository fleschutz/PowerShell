<#
.SYNOPSIS
	Lists system information of the local computer
.DESCRIPTION
	This PowerShell script lists system information of the local computer.
.EXAMPLE
	PS> ./list-system-info.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

# RAM
$RAM = Get-WmiObject -Query "SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem"

$totalRAM = [math]::Round($RAM.TotalVisibleMemorySize/1MB, 2)
$freeRAM = [math]::Round($RAM.FreePhysicalMemory/1MB, 2)
$usedRAM = [math]::Round(($RAM.TotalVisibleMemorySize - $RAM.FreePhysicalMemory)/1MB, 2)

# Operating System
$OS = Get-WmiObject -class Win32_OperatingSystem

$OS_Name = $OS.Caption
$OS_InstallDate = $OS.ConvertToDateTime($OS.InstallDate)
$OS_LastBootUpTime = $OS.ConvertToDateTime($OS.LastBootUpTime)
$OS_Architecture = $OS.OSArchitecture
$OS_SystemDrive = $OS.SystemDrive
$OS_WindowsDirectory = $OS.WindowsDirectory
$OS_BuildNumber = $OS.BuildNumber
$OS_SerialNumber = $OS.SerialNumber
$OS_Version = $OS.Version
$OS_Manufacturer = $OS.Manufacturer

# Computer System
$CS = Get-WmiObject -class Win32_ComputerSystem

$CS_Name = $CS.Name
$CS_Owner = $CS.PrimaryOwnerName

# CPU
$CPU = Get-WmiObject -class Win32_Processor

$CPU_Name = $CPU.Name
$CPU_Manufacturer = $CPU.Manufacturer
$CPU_MaxClockSpeed = $CPU.MaxClockSpeed / 1000
$CPU_Used = (Get-WmiObject win32_processor).LoadPercentage
$CPU_Free = 100 - $CPU_Used

# Disk
$Disk = Get-WmiObject -class Win32_LogicalDisk -Filter "DeviceID='C:'"
$Disk_ID = $Disk.DeviceID
$Disk_TotalSpace = [math]::Round($Disk.Size/1GB, 2)
$Disk_FreeSpace = [math]::Round($Disk.FreeSpace/1GB, 2)
$Disk_UsedSpace = [math]::Round(($Disk.Size - $Disk.FreeSpace)/1GB, 2)

# System Info
$systeminfo = systeminfo

# IP Config
$ipconfig = ipconfig

# Driver Query
$driverquery = driverquery

# Running Services
$netstart = net start

# Create info object
$infoprop = @{
    'RAM_total'= $totalRAM;
    'RAM_free'= $freeRAM;
    'RAM_used'= $usedRAM;
    'OS_Name'= $OS_Name;
    'OS_InstallDate'= $OS_InstallDate;
    'OS_LastBootUpTime'= $OS_LastBootUpTime;
    'OS_Architecture'= $OS_Architecture;
    'OS_SystemDrive'= $OS_SystemDrive;
    'OS_WindowsDirectory'= $OS_WindowsDirectory;
    'OS_BuildNumber'= $OS_BuildNumber;
    'OS_SerialNumber'= $OS_SerialNumber;
    'OS_Version'= $OS_Version;
    'OS_Manufacturer'= $OS_Manufacturer;
    'CS_Name'= $CS_Name;
    'CS_Owner'= $CS_Owner;
    'CPU_Name'= $CPU_Name;
    'CPU_Manufacturer'= $CPU_Manufacturer;
    'CPU_MaxClockSpeed'= $CPU_MaxClockSpeed;
    'CPU_Used'= $CPU_Used;
    'CPU_Free'= $CPU_Free;
    'Disk_ID'= $Disk_ID;
    'Disk_TotalSpace'= $Disk_TotalSpace;
    'Disk_FreeSpace'= $Disk_FreeSpace;
    'Disk_UsedSpace'= $Disk_UsedSpace;
    'systeminfo'= $systeminfo;
    'ipconfig'= $ipconfig;
    'driverquery'= $driverquery;
    'netstart'= $netstart;
}

$info = New-Object -TypeName PSObject -Prop $infoprop

# Convert info to JSON
$info = $info | ConvertTo-JSON

# Output 
$info
exit 0 # success
