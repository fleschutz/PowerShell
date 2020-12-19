#!/snap/bin/powershell

# Syntax:       ./write-MOTD.ps1 
# Description:	writes the message of the day (MOTD)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0


# Retrieve information:

$UserName = $(whoami)
$ComputerName = $(hostname)
$CurrentDate = Get-Date
$PowerShellVersion = "{0}.{1}" -f $PSVersionTable.PSVersion.Major,$PSVersionTable.PSVersion.Minor

#$OS = Get-CimInstance -ClassName Win32_OperatingSystem
#$Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object -Property DeviceID -eq $OS.SystemDrive
#$Processor = Get-CimInstance -ClassName Win32_Processor
$Process_Count = (Get-Process).Count
#$OS_Name = $ReturnedValues.Operating_System.Caption
#$Kernel_Info = $ReturnedValues.Operating_System.Version
#$Process_Count = $ReturnedValues.Process_Count
#$Uptime = "$(($Uptime = $CurrentDate - $($ReturnedValues.Operating_System.LastBootUpTime)).Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
#$CPU_Info = $ReturnedValues.Processor.Name -replace '\(C\)', '' -replace '\(R\)', '' -replace '\(TM\)', '' -replace 'CPU', '' -replace '\s+', ' '
#$Current_Load = $ReturnedValues.Processor.LoadPercentage    
#$Memory_Size = "{0}mb/{1}mb Used" -f (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))-
#([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory/1KB))),([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))    
#$Disk_Size = "{0}gb/{1}gb Used" -f (([math]::round($ReturnedValues.Logical_Disk.Size/1GB)-
#[math]::round($ReturnedValues.Logical_Disk.FreeSpace/1GB))),([math]::round($ReturnedValues.Logical_Disk.Size/1GB))

# Write to the Console

Write-Host ""
Write-Host ""
Write-Host " ,.=:^!^!t3Z3z., " -ForegroundColor Red
Write-Host " :tt:::tt333EE3 " -ForegroundColor Red
Write-Host " Et:::ztt33EEE " -NoNewline -ForegroundColor Red
Write-Host " @Ee., ..,           $CurrentDate" -ForegroundColor Green
Write-Host " ;tt:::tt333EE7" -NoNewline -ForegroundColor Red
Write-Host " ;EEEEEEttttt33# " -ForegroundColor Green
Write-Host " :Et:::zt333EEQ." -NoNewline -ForegroundColor Red
Write-Host " SEEEEEttttt33QL " -NoNewline -ForegroundColor Green
Write-Host "   User: " -NoNewline -ForegroundColor Red
Write-Host "$UserName" -ForegroundColor Cyan
Write-Host " it::::tt333EEF" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEttttt33F " -NoNewline -ForeGroundColor Green
Write-Host "    Hostname: " -NoNewline -ForegroundColor Red
Write-Host "$ComputerName" -ForegroundColor Cyan
Write-Host " ;3=*^``````'*4EEV" -NoNewline -ForegroundColor Red
Write-Host " :EEEEEEttttt33@. " -NoNewline -ForegroundColor Green
Write-Host "   OS: " -NoNewline -ForegroundColor Red
Write-Host "$OS_Name" -ForegroundColor Cyan
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
Write-Host "   Shell: " -NoNewline -ForegroundColor Red
Write-Host "Powershell $PowerShellVersion" -ForegroundColor Cyan
Write-Host " i::::::::zt33F" -NoNewline -ForegroundColor Cyan
Write-Host " AEEEtttt::::ztF " -NoNewline -ForegroundColor Yellow
Write-Host "    CPU: " -NoNewline -ForegroundColor Red
Write-Host "$CPU_Info" -ForegroundColor Cyan
Write-Host " ;:::::::::t33V" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEttttt::::t3 " -NoNewline -ForegroundColor Yellow
Write-Host "    Processes: " -NoNewline -ForegroundColor Red
Write-Host "$Process_Count" -ForegroundColor Cyan
Write-Host " E::::::::zt33L" -NoNewline -ForegroundColor Cyan
Write-Host " @EEEtttt::::z3F " -NoNewline -ForegroundColor Yellow
Write-Host "    Current Load: " -NoNewline -ForegroundColor Red
Write-Host "$Current_Load" -ForegroundColor Cyan
#Write-Host "%" -ForegroundColor Cyan
Write-Host " {3=*^``````'*4E3)" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEtttt:::::tZ`` " -NoNewline -ForegroundColor Yellow
Write-Host "   Memory: " -NoNewline -ForegroundColor Red
Write-Host "$Memory_Size" -ForegroundColor Cyan
Write-Host "              ``" -NoNewline -ForegroundColor Cyan
Write-Host " :EEEEtttt::::z7 " -NoNewline -ForegroundColor Yellow
Write-Host "    System Volume: " -NoNewline -ForegroundColor Red
Write-Host "$Disk_Size" -ForegroundColor Cyan
Write-Host "                 'VEzjt:;;z>*`` " -ForegroundColor Yellow
Write-Host ""
exit 0
