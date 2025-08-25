Script: *write-motd.ps1*
========================

This PowerShell script writes the message of the day (MOTD).

Parameters
----------
```powershell
PS> ./write-motd.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./write-motd

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Writes the message of the day
.DESCRIPTION
	This PowerShell script writes the message of the day (MOTD).
.EXAMPLE
	PS> ./write-motd
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param ()

# Retrieve information:
[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
$dt = [datetime]::Now
$day = $dt.ToLongDateString().split(',')[1].trim()
if ($day.EndsWith('1')) { $day += 'st' } elseif ($day.EndsWith('2')) { $day += 'nd' } elseif ($day.EndsWith('3')) { $day += 'rd' } else { $day += 'th' }
$CurrentTime = "$day, $($dt.Year) $($dt.Hour):$($dt.Minute)"
$TimeZone = (Get-TimeZone).id

$UserName = [Environment]::USERNAME
$ComputerName = [System.Net.Dns]::GetHostName().ToLower()
$OSName = "$((Get-WmiObject win32_operatingsystem).caption) Build: $([System.Environment]::OSVersion.Version.Build)"
$Kernel = "NT" # todo
$Kernel_Info = "" # todo

$BootTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1
$TimeSpan = New-TimeSpan -Start $BootTime.TimeCreated.Date -End (Get-Date)
$Uptime = "$($TimeSpan.Days) days, $($TimeSpan.Hours) hours, $($TimeSpan.Minutes) minutes"
$PowerShellVersion = $PSVersionTable.PSVersion
$PowerShellEdition = $PSVersionTable.PSEdition

$CPU_Info = $env:PROCESSOR_IDENTIFIER + ' Rev: ' + $env:PROCESSOR_REVISION
$NumberOfProcesses = (Get-Process).Count
$CurrentLoad = "{0}%" -f $(Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average)
# $Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object -Property DeviceID -eq $OS.SystemDrive
# $Processor = Get-CimInstance -ClassName Win32_Processor
# $Memory_Size = "{0}mb/{1}mb Used" -f (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize / 1KB)) - ([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory / 1KB))), ([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize / 1KB))    
$DriveDetails = Get-PSDrive C
$DiskSize = "{0}GB free of {1}GB" -f (([math]::round($DriveDetails.Free / 1GB), ([math]::round(($DriveDetails.Used + $DriveDetails.Free) / 1GB))))

# Print results:
[Environment]::NewLine
Write-Host " ,.=:^!^!t3Z3z., " -ForegroundColor Red
Write-Host " :tt:::tt333EE3 " -ForegroundColor Red
Write-Host " Et:::ztt33EEE " -ForegroundColor Red -NoNewline
Write-Host " @Ee., ..,     " -ForegroundColor green -NoNewline
Write-Host "      Time: " -ForegroundColor DarkGray -NoNewline
Write-Host "$CurrentTime" -ForegroundColor Cyan
Write-Host " ;tt:::tt333EE7" -ForegroundColor Red -NoNewline
Write-Host " ;EEEEEEttttt33# " -ForegroundColor Green -NoNewline
Write-Host "    Timezone: " -ForegroundColor DarkGray -NoNewline
Write-Host "$TimeZone" -ForegroundColor Cyan
Write-Host " :Et:::zt333EEQ." -NoNewline -ForegroundColor Red
Write-Host " SEEEEEttttt33QL " -NoNewline -ForegroundColor Green
Write-Host "   User: " -NoNewline -ForegroundColor DarkGray
Write-Host "$UserName" -ForegroundColor Cyan
Write-Host " it::::tt333EEF" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEttttt33F " -NoNewline -ForegroundColor Green
Write-Host "    Host: " -NoNewline -ForegroundColor DarkGray
Write-Host "$ComputerName" -ForegroundColor Cyan
Write-Host " ;3=*^``````'*4EEV" -NoNewline -ForegroundColor Red
Write-Host " :EEEEEEttttt33@. " -NoNewline -ForegroundColor Green
Write-Host "   OS: " -NoNewline -ForegroundColor DarkGray
Write-Host "$OSName" -ForegroundColor Cyan
Write-Host " ,.=::::it=., " -NoNewline -ForegroundColor Cyan
Write-Host "``" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEtttz33QF " -NoNewline -ForegroundColor Green
Write-Host "    Kernel: " -NoNewline -ForegroundColor DarkGray
Write-Host "$Kernel " -NoNewline -ForegroundColor Cyan
Write-Host "$Kernel_Info" -ForegroundColor Cyan
Write-Host " ;::::::::zt33) " -NoNewline -ForegroundColor Cyan
Write-Host " '4EEEtttji3P* " -NoNewline -ForegroundColor Green
Write-Host "     Uptime: " -NoNewline -ForegroundColor DarkGray
Write-Host "$Uptime" -ForegroundColor Cyan
Write-Host " :t::::::::tt33." -NoNewline -ForegroundColor Cyan
Write-Host ":Z3z.. " -NoNewline -ForegroundColor Yellow
Write-Host " ````" -NoNewline -ForegroundColor Green
Write-Host " ,..g. " -NoNewline -ForegroundColor Yellow
Write-Host "   PowerShell: " -NoNewline -ForegroundColor DarkGray
Write-Host "$PowerShellVersion $PowerShellEdition" -ForegroundColor Cyan
Write-Host " i::::::::zt33F" -NoNewline -ForegroundColor Cyan
Write-Host " AEEEtttt::::ztF " -NoNewline -ForegroundColor Yellow
Write-Host "    CPU: " -NoNewline -ForegroundColor DarkGray
Write-Host "$CPU_Info" -ForegroundColor Cyan
Write-Host " ;:::::::::t33V" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEttttt::::t3 " -NoNewline -ForegroundColor Yellow
Write-Host "    Processes: " -NoNewline -ForegroundColor DarkGray
Write-Host "$NumberOfProcesses" -ForegroundColor Cyan
Write-Host " E::::::::zt33L" -NoNewline -ForegroundColor Cyan
Write-Host " @EEEtttt::::z3F " -NoNewline -ForegroundColor Yellow
Write-Host "    Current Load: " -NoNewline -ForegroundColor DarkGray
Write-Host "$CurrentLoad" -ForegroundColor Cyan
Write-Host " {3=*^``````'*4E3)" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEtttt:::::tZ`` " -NoNewline -ForegroundColor Yellow
Write-Host "   Memory: " -NoNewline -ForegroundColor DarkGray
Write-Host "$Memory_Size" -ForegroundColor Cyan
Write-Host "              ``" -NoNewline -ForegroundColor Cyan
Write-Host " :EEEEtttt::::z7 " -NoNewline -ForegroundColor Yellow
Write-Host "    System Volume: " -NoNewline -ForegroundColor DarkGray
Write-Host "$DiskSize" -ForegroundColor Cyan
Write-Host "                 'VEzjt:;;z>*`` " -ForegroundColor Yellow
[Environment]::NewLine
exit 0 # success
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:29)*
