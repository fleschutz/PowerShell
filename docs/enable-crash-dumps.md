Script: *enable-crash-dumps.ps1*
========================

This PowerShell script enables the writing of crash dumps.

Parameters
----------
```powershell
PS> ./enable-crash-dumps.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./enable-crash-dumps.ps1

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
	Enables the writing of crash dumps
.DESCRIPTION
	This PowerShell script enables the writing of crash dumps.
.EXAMPLE
	PS> ./enable-crash-dumps.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

##################################################################
#                                                                #
# Written by: Ryan Waters                                        #
#                                                                #
# Program: Get-Dump.ps1                                          #
# Date: 2-06-2020                                                #
# Purpose: To set registry keys to gather a WER Usermode Dump    #
#          and be able to change from a custom, mini, or FULL    #
#          Dumps for ease of use for customers and others.       #
#                                                                #
# EULA: Code is free to use for all, and free to distribute      #
#       I just ask that you leave the credit information and     #
#       this EULA and Comment Section in tact and do not delete. #
#                                                                #
# Bitwise Values:  (For reference)                               #
#                                                                #
# 0x00000000 -  MiniDumpNormal                                   #
# 0x00000001 -  MiniDumpWithDataSegs                             #
# 0x00000002 -  MiniDumpWithFullMemory                           #
# 0x00000004 -  MiniDumpWithHandleData                           #
# 0x00000008 -  MiniDumpFilterMemory                             #
# 0x00000010 -  MiniDumpScanMemory                               #
# 0x00000020 -  MiniDumpWithUnloadedModules                      #
# 0x00000040 -  MiniDumpWithIndirectlyReferenced                 #
# 0x00000080 -  MemoryMiniDumpFilterModulePaths                  #
# 0x00000100 -  MiniDumpWithProcessThreadData                    #
# 0x00000200 -  MiniDumpWithPrivateReadWriteMemory               #
# 0x00000400 -  MiniDumpWithoutOptionalData                      #
# 0x00000800 -  MiniDumpWithFullMemoryInfo                       #
# 0x00001000 -  MiniDumpWithThreadInfo                           #
# 0x00002000 -  MiniDumpWithCodeSegs                             #
# 0x00004000 -  MiniDumpWithoutAuxiliaryState                    #
# 0x00008000 -  MiniDumpWithFullAuxiliaryState                   #
# 0x00010000 -  MiniDumpWithPrivateWriteCopyMemory               #
# 0x00020000 -  MiniDumpIgnoreInaccessibleMemory                 #
# 0x00040000 -  MiniDumpWithTokenInformation                     #
#                                                                #
##################################################################

# Check if running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: This script requires administrator privileges to modify registry keys." -ForegroundColor Red
    Write-Host "Please run this script as an administrator:" -ForegroundColor Yellow
    Write-Host "1. Right-click on PowerShell" -ForegroundColor Yellow
    Write-Host "2. Select 'Run as administrator'" -ForegroundColor Yellow
    Write-Host "3. Re-run this script" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

#Setting Values:
$MDN = '0'
$MDWDS = '1'
$MDWFM = '2'
$MDWHD = '4'
$MDFM = '8'
$MDSM = '10'
$MDWUM = '20'
$MDWIR = '40'
$MMDFMP = '80'
$MDWPTD = '100'
$MDWPRWM = '200'
$MDWOD = '400'
$MDWFMI = '800'
$MDWTI = '1000'
$MDWCS = '2000'
$MDWAS = '4000'
$MDWFAS = '8000'
$MDWPWCM = '10000'
$MDIIM = '20000'
$MDWTOI = '40000'

$a = $MDN
$b = $MDWDS
$c = $MDWFM
$d = $MDWHD
$e = $MDFM
$f = $MDSM
$g = $MDWUM
$h = $MDWIR
$i = $MMDFMP
$j = $MDWPTD
$k = $MDWPRWM
$l = $MDWOD
$m = $MDWFMI
$n = $MDWTI
$o = $MDWCS
$p = $MDWAS
$q = $MDWFAS
$r = $MDWPWCM
$s = $MDIIM
$t = $MDWTOI

$0x = "0x"

$array = @()

Clear-Host
Write-Host "Setting up your machine to receive Usermode Dumps via WER."
Start-Sleep -seconds 3

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpFolder" -Value "%LOCALAPPDATA%\CrashDumps" -PropertyType ExpandString -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpCount" -Value "10" -PropertyType DWORD -Force

clear-host
write-host "What would you like to do?"
write-host "(0) Disable Dumps and restore system to factory."
write-host "(1) Enable System for Full Dumps."
write-host "(2) Enable System for Mini Dumps."
write-host "(3) Enable System for custom dump with options."
$NCD = Read-Host "Enter a number option"

If ($NCD -eq '3')
{
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpType" -Value "0" -PropertyType DWORD -Force
    Do
    {
        clear-host
        write-host "Here are the optional custom dump  to add to your custom dump parameters:"
        write-host "(1)  Mini Dump Normal"
        write-host "(2)  Mini Dump With Data Segs"
        write-host "(3)  Mini Dump With Full Memory"
        write-host "(4)  Mini Dump With Handle Data"
        write-host "(5)  Mini Dump Filter Memory"
        write-host "(6)  Mini Dump Scan Memory"
        write-host "(7)  Mini Dump With Unloaded Modules"
        write-host "(8)  Mini Dump With Indirectly Referenced"
        write-host "(9)  Memory Mini Dump Filter Module Paths"
        write-host "(10) Mini Dump With Process Thread Data"
        write-host "(11) Mini Dump With Private Read Write Memory"
        write-host "(12) Mini Dump Without Optional Data"
        write-host "(13) Mini Dump With Full Memory Info"
        write-host "(14) Mini Dump With Thread Info"
        write-host "(15) Mini Dump With Code Segs"
        write-host "(16) Mini Dump Without Auxiliary State"
        write-host "(17) Mini Dump With Full Auxiliary State"
        write-host "(18) Mini Dump With Private Write Copy Memory"
        write-host "(19) Mini Dump Ignore Inaccessible Memory"
        write-host "(20) Mini Dump With Token Information"
        $Option = Read-Host "Enter one number value at a time and press enter. (Press 'q' when finished)"
        if($Option -eq '1')
        {
            $array += [int]$a
        }
        ElseIf($Option -eq '2')
        {
            $array += [int]$b
        }
        ElseIf($Option -eq '3')
        {
            $array += [int]$c
        }
        ElseIf($Option -eq '4')
        {
            $array += [int]$d
        }
        ElseIf($Option -eq '5')
        {
            $array += [int]$e
        }
        ElseIf($Option -eq '6')
        {
            $array += [int]$f
        }
        ElseIf($Option -eq '7')
        {
            $array += [int]$g
        }
        ElseIf($Option -eq '8')
        {
            $array += [int]$h
        }
        ElseIf($Option -eq '9')
        {
            $array += [int]$i
        }
        ElseIf($Option -eq '10')
        {
            $array += [int]$j
        }
        ElseIf($Option -eq '11')
        {
        $array += [int]$k
        }
        ElseIf($Option -eq '12')
        {
            $array += [int]$l
        }
        ElseIf($Option -eq '13')
        {
            $array += [int]$m
        }
        ElseIf($Option -eq '14')
        {
            $array += [int]$n
        }
        ElseIf($Option -eq '15')
        {
            $array += [int]$o
        }
        ElseIf($Option -eq '16')
        {
            $array += [int]$p
        }
        ElseIf($Option -eq '17')
        {
            $array += [int]$q
        } 
        ElseIf($Option -eq '18')
        {
            $array += [int]$r
        } 
        ElseIf($Option -eq '19')
        {
            $array += [int]$s
        } 
        ElseIf($Option -eq '20')
        {
            $array += [int]$t
        }
        ElseIf($Option -eq 'q')
        {
            write-host "Closing application."
            Start-Sleep -seconds 2
        }
        Else
        {
            write-host "Invalid Option, Try again."
            Start-Sleep -seconds 2
        }  
                                               
    }
    While($Option -ne "q")
    $sum = $array -join '+'
    $SumArray = Invoke-Expression $sum
    $FinalSum = $0x + $SumArray

    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "CustomDumpFlags" -Value "$FinalSum" -PropertyType DWORD -Force

    write-host " "
    write-host "Setting up the system for crash dumps requires a reboot"
}
ElseIf ($NCD -eq '0')
{
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpCount" -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpType" -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpFolder" -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "CustomDumpFlags" -Force -ErrorAction SilentlyContinue
    write-host " "
    $reboot = read-host "Registry reset to factory settings and cleared.  It is recommended to restart your machine, would you like to now?"
    if($reboot -eq "Yes" -or $reboot -eq "Y" -or $reboot -eq "yes" -or $reboot -eq "y")
    {
        shutdown -r
    }
    Else
    {
        write-host "Please restart the machine for settings to take effect at your convenience."
    }
}
ElseIf ($NCD -eq '1')
{
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpType" -Value "2" -PropertyType DWORD -Force
    write-host "The computer has been set up to create a Full Sized Dump and will be located in %LOCALAPPDATA%\CrashDumps."
    write-host "The computer must also restart for settings to take effect.  Would you like to now? (Y/n)"
    if($reboot -eq "Yes" -or $reboot -eq "Y" -or $reboot -eq "yes" -or $reboot -eq "y")
    {
        shutdown -r
    }
    Else
    {
        write-host "Please restart the machine for settings to take effect at your convenience."
    }
}
ElseIf ($NCD -eq '2')
{
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" -Name "DumpType" -Value "1" -PropertyType DWORD -Force
    write-host "The computer has been set up to create a Mini Dump and will be located in %LOCALAPPDATA%\CrashDumps."
    write-host "The computer must also restart for settings to take effect.  Would you like to now? (Y/n)"
    if($reboot -eq "Yes" -or $reboot -eq "Y" -or $reboot -eq "yes" -or $reboot -eq "y")
    {
        shutdown -r
    }
    Else
    {
        write-host "Please restart the machine for settings to take effect at your convenience."
    }
}
Else
{
    Write-Host "You did not enter a valid option.  Please re-run Get-Dump.ps1"
    Start-Sleep -seconds 5
}
exit 0 # success
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:25)*
