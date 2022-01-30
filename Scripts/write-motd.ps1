<#
.SYNOPSIS
	Writes the message of the day (MOTD)
.DESCRIPTION
	This PowerShell script writes the message of the day (MOTD).
.EXAMPLE
	PS> ./write-motd
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

# Retrieve information:
$CurrentTime = Get-Date -format "yyyy-MM-dd HH:mm"
$TimeZone = (Get-TimeZone).id
$UserName = $(whoami)
$ComputerName = $(hostname)
$OSName = $PSVersionTable.OS
$PowerShellVersion = $PSVersionTable.PSVersion
$PowerShellEdition = $PSVersionTable.PSEdition
$UptimeDays = (Get-Uptime).Days
$UptimeHours = (Get-Uptime).Hours
$Uptime = "$UptimeDays days, $UptimeHours hours"
$NumberOfProcesses = (Get-Process).Count

#$Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object -Property DeviceID -eq $OS.SystemDrive
#$Processor = Get-CimInstance -ClassName Win32_Processor
#$Current_Load = $ReturnedValues.Processor.LoadPercentage    
#$Memory_Size = "{0}mb/{1}mb Used" -f (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))-
#([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory/1KB))),([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))    
#$Disk_Size = "{0}gb/{1}gb Used" -f (([math]::round($ReturnedValues.Logical_Disk.Size/1GB)-
#[math]::round($ReturnedValues.Logical_Disk.FreeSpace/1GB))),([math]::round($ReturnedValues.Logical_Disk.Size/1GB))

# Write to the Console

write-host ""
write-host ""
write-host " ,.=:^!^!t3Z3z., " -foregroundcolor Red
write-host " :tt:::tt333EE3 " -foregroundcolor Red

write-host " Et:::ztt33EEE " -foregroundcolor Red -nonewline
write-host " @Ee., ..,     " -foregroundcolor green -nonewline
write-host "      Time: " -foregroundcolor Red -nonewline
write-host "$CurrentTime" -foregroundcolor Cyan

write-host " ;tt:::tt333EE7" -foregroundcolor Red -nonewline
write-host " ;EEEEEEttttt33# " -foregroundcolor Green -nonewline
write-host "    Timezone: " -foregroundcolor Red -nonewline
write-host "$TimeZone" -foregroundcolor Cyan

write-host " :Et:::zt333EEQ." -NoNewline -foregroundcolor Red
write-host " SEEEEEttttt33QL " -NoNewline -foregroundcolor Green
write-host "   User: " -NoNewline -foregroundcolor Red
write-host "$UserName" -foregroundcolor Cyan
write-host " it::::tt333EEF" -NoNewline -foregroundcolor Red
write-host " @EEEEEEttttt33F " -NoNewline -ForeGroundColor Green
write-host "    Hostname: " -NoNewline -foregroundcolor Red
write-host "$ComputerName" -foregroundcolor Cyan
write-host " ;3=*^``````'*4EEV" -NoNewline -foregroundcolor Red
write-host " :EEEEEEttttt33@. " -NoNewline -foregroundcolor Green
write-host "   OS: " -NoNewline -foregroundcolor Red
write-host "$OSName" -foregroundcolor Cyan
write-host " ,.=::::it=., " -NoNewline -foregroundcolor Cyan
write-host "``" -NoNewline -foregroundcolor Red
write-host " @EEEEEEtttz33QF " -NoNewline -foregroundcolor Green
write-host "    Kernel: " -NoNewline -foregroundcolor Red
write-host "NT " -NoNewline -foregroundcolor Cyan
write-host "$Kernel_Info" -foregroundcolor Cyan
write-host " ;::::::::zt33) " -NoNewline -foregroundcolor Cyan
write-host " '4EEEtttji3P* " -NoNewline -foregroundcolor Green
write-host "     Uptime: " -NoNewline -foregroundcolor Red
write-host "$Uptime" -foregroundcolor Cyan
write-host " :t::::::::tt33." -NoNewline -foregroundcolor Cyan
write-host ":Z3z.. " -NoNewline -foregroundcolor Yellow
write-host " ````" -NoNewline -foregroundcolor Green
write-host " ,..g. " -NoNewline -foregroundcolor Yellow
write-host "   PowerShell: " -NoNewline -foregroundcolor Red
write-host "$PowerShellVersion $PowerShellEdition" -foregroundcolor Cyan
write-host " i::::::::zt33F" -NoNewline -foregroundcolor Cyan
write-host " AEEEtttt::::ztF " -NoNewline -foregroundcolor Yellow
write-host "    CPU: " -NoNewline -foregroundcolor Red
write-host "$CPU_Info" -foregroundcolor Cyan
write-host " ;:::::::::t33V" -NoNewline -foregroundcolor Cyan
write-host " ;EEEttttt::::t3 " -NoNewline -foregroundcolor Yellow
write-host "    Processes: " -NoNewline -foregroundcolor Red
write-host "$NumberOfProcesses" -foregroundcolor Cyan
write-host " E::::::::zt33L" -NoNewline -foregroundcolor Cyan
write-host " @EEEtttt::::z3F " -NoNewline -foregroundcolor Yellow
write-host "    Current Load: " -NoNewline -foregroundcolor Red
write-host "$Current_Load" -foregroundcolor Cyan
#write-host "%" -foregroundcolor Cyan
write-host " {3=*^``````'*4E3)" -NoNewline -foregroundcolor Cyan
write-host " ;EEEtttt:::::tZ`` " -NoNewline -foregroundcolor Yellow
write-host "   Memory: " -NoNewline -foregroundcolor Red
write-host "$Memory_Size" -foregroundcolor Cyan
write-host "              ``" -NoNewline -foregroundcolor Cyan
write-host " :EEEEtttt::::z7 " -NoNewline -foregroundcolor Yellow
write-host "    System Volume: " -NoNewline -foregroundcolor Red
write-host "$Disk_Size" -foregroundcolor Cyan
write-host "                 'VEzjt:;;z>*`` " -foregroundcolor Yellow
write-host ""
exit 0 # success
