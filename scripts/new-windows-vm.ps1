$VMName = "windows"

 $VM = @{
     Name = $VMName
     MemoryStartupBytes = 4GB
     Generation = 2
     NewVHDPath = "C:\VirtualMachines\$VMName\Virtual Hard Disks\$VMName.vhdx"
     NewVHDSizeBytes = 50GB
     BootDevice = "VHD"
     Path = "C:\VirtualMachines\"
     SwitchName = 'vSwitch'
 }

 New-VM @VM
 Set-VMProcessor $VMName -count 1
 Add-VMDvdDrive $VMName
 Set-VMDvdDrive $VMName -Path "C:\iso\Win10_21H1_English_x64.iso"
exit 0 # success