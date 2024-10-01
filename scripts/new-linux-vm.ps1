$VMName = "linux"

 $VM = @{
     Name = $VMName
     MemoryStartupBytes = 1GB
     Generation = 2
     NewVHDPath = "C:\VirtualMachines\$VMName\Virtual Hard Disks\$VMName.vhdx"
     NewVHDSizeBytes = 30GB
     BootDevice = "VHD"
     Path = "C:\VirtualMachines\"
     SwitchName = 'vSwitch'
 }

 New-VM @VM
 Set-VMProcessor $VMName -count 1
 Add-VMDvdDrive $VMName
 Set-VMDvdDrive $VMName -Path "C:\iso\CentOS-8.3.2011-x86_64-minimal.iso"
 Set-VMFirmware -EnableSecureBoot Off $VMName
exit 0 # success