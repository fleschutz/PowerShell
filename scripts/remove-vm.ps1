$VMName = "debian"
$WarningPreference = 'SilentlyContinue' # If VM already stopped
Stop-VM $VMName -Force
Remove-VM $VMName -Force
Remove-Item -Path "C:\VirtualMachines\$VMName" -Recurse
exit 0 # success