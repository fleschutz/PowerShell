<#
 .SYNOPSIS
   Writes the message of the day
 .DESCRIPTION
   This PowerShell script writes the message of the day (MOTD).
 .EXAMPLE
   PS> ./write-motd
.NOTES
   Author: Markus Fleschutz / License: CC0
.LINK
   https://github.com/fleschutz/PowerShell
#>
param ()

# Retrieve information:
$TimeZone = (Get-TimeZone).id
$UserName = [Environment]::USERNAME
$ComputerName = [System.Net.Dns]::GetHostName().ToLower()
$OSName = "$((Get-WmiObject win32_operatingsystem).caption) Build: $([System.Environment]::OSVersion.Version.Build)"
$PowerShellVersion = $PSVersionTable.PSVersion
$PowerShellEdition = $PSVersionTable.PSEdition
$dt = [datetime]::Now; $day = $dt.ToLongDateString().split(',')[1].trim()
if ($day.EndsWith('1')) { $day += 'st' }elseif ($day.EndsWith('2')) { $day += 'nd' }elseif ($day.EndsWith('3')) { $day += 'rd' }else { $day += 'th' }
$CurrentTime = "$day, $($dt.Year) $($dt.Hour):$($dt.Minute)"
$Uptime = 'S' + $(net statistics workstation | find "Statistics since").Substring(12).Trim();
$NumberOfProcesses = (Get-Process).Count
$CPU_Info = $env:PROCESSOR_IDENTIFIER + ' Rev: ' + $env:PROCESSOR_REVISION
# $Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object -Property DeviceID -eq $OS.SystemDrive
# $Processor = Get-CimInstance -ClassName Win32_Processor
$Current_Load = "{0}%" -f $(Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average)
# $Memory_Size = "{0}mb/{1}mb Used" -f (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize / 1KB)) - ([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory / 1KB))), ([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize / 1KB))    
# $Disk_Size = "{0}gb/{1}gb Used" -f (([math]::round($ReturnedValues.Logical_Disk.Size / 1GB) - [math]::round($ReturnedValues.Logical_Disk.FreeSpace / 1GB))), ([math]::round($ReturnedValues.Logical_Disk.Size / 1GB))
# Print Results
[Environment]::NewLine
Write-Host " ,.=:^!^!t3Z3z., " -ForegroundColor Red
Write-Host " :tt:::tt333EE3 " -ForegroundColor Red
Write-Host " Et:::ztt33EEE " -ForegroundColor Red -NoNewline
Write-Host " @Ee., ..,     " -ForegroundColor green -NoNewline
Write-Host "      Time: " -ForegroundColor Red -NoNewline
Write-Host "$CurrentTime" -ForegroundColor Cyan
Write-Host " ;tt:::tt333EE7" -ForegroundColor Red -NoNewline
Write-Host " ;EEEEEEttttt33# " -ForegroundColor Green -NoNewline
Write-Host "    Timezone: " -ForegroundColor Red -NoNewline
Write-Host "$TimeZone" -ForegroundColor Cyan
Write-Host " :Et:::zt333EEQ." -NoNewline -ForegroundColor Red
Write-Host " SEEEEEttttt33QL " -NoNewline -ForegroundColor Green
Write-Host "   User: " -NoNewline -ForegroundColor Red
Write-Host "$UserName" -ForegroundColor Cyan
Write-Host " it::::tt333EEF" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEttttt33F " -NoNewline -ForegroundColor Green
Write-Host "    Hostname: " -NoNewline -ForegroundColor Red
Write-Host "$ComputerName" -ForegroundColor Cyan
Write-Host " ;3=*^``````'*4EEV" -NoNewline -ForegroundColor Red
Write-Host " :EEEEEEttttt33@. " -NoNewline -ForegroundColor Green
Write-Host "   OS: " -NoNewline -ForegroundColor Red
Write-Host "$OSName" -ForegroundColor Cyan
Write-Host " ,.=::::it=., " -NoNewline -ForegroundColor Cyan
Write-Host "``" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEtttz33QF " -NoNewline -ForegroundColor Green
Write-Host "    Kernel: " -NoNewline -ForegroundColor Red
Write-Host "NT " -NoNewline -ForegroundColor Cyan
Write-Host "$Kernel_Info" -ForegroundColor Cyan
Write-Host " ;::::::::zt33) " -NoNewline -ForegroundColor Cyan
Write-Host " '4EEEtttji3P* " -NoNewline -ForegroundColor Green
Write-Host "     Uptime: " -NoNewline -ForegroundColor Red
Write-Host "$Uptime" -ForegroundColor Cyan
Write-Host " :t::::::::tt33." -NoNewline -ForegroundColor Cyan
Write-Host ":Z3z.. " -NoNewline -ForegroundColor Yellow
Write-Host " ````" -NoNewline -ForegroundColor Green
Write-Host " ,..g. " -NoNewline -ForegroundColor Yellow
Write-Host "   PowerShell: " -NoNewline -ForegroundColor Red
Write-Host "$PowerShellVersion $PowerShellEdition" -ForegroundColor Cyan
Write-Host " i::::::::zt33F" -NoNewline -ForegroundColor Cyan
Write-Host " AEEEtttt::::ztF " -NoNewline -ForegroundColor Yellow
Write-Host "    CPU: " -NoNewline -ForegroundColor Red
Write-Host "$CPU_Info" -ForegroundColor Cyan
Write-Host " ;:::::::::t33V" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEttttt::::t3 " -NoNewline -ForegroundColor Yellow
Write-Host "    Processes: " -NoNewline -ForegroundColor Red
Write-Host "$NumberOfProcesses" -ForegroundColor Cyan
Write-Host " E::::::::zt33L" -NoNewline -ForegroundColor Cyan
Write-Host " @EEEtttt::::z3F " -NoNewline -ForegroundColor Yellow
Write-Host "    Current Load: " -NoNewline -ForegroundColor Red
Write-Host "$Current_Load" -ForegroundColor Cyan
Write-Host " {3=*^``````'*4E3)" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEtttt:::::tZ`` " -NoNewline -ForegroundColor Yellow
Write-Host "   Memory: " -NoNewline -ForegroundColor Red
Write-Host "$Memory_Size" -ForegroundColor Cyan
Write-Host "              ``" -NoNewline -ForegroundColor Cyan
Write-Host " :EEEEtttt::::z7 " -NoNewline -ForegroundColor Yellow
Write-Host "    System Volume: " -NoNewline -ForegroundColor Red
Write-Host "$Disk_Size" -ForegroundColor Cyan
Write-Host "                 'VEzjt:;;z>*`` " -ForegroundColor Yellow
[Environment]::NewLine
