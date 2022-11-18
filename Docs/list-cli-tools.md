## The *list-cli-tools.ps1* PowerShell Script

list-cli-tools.ps1 


## Parameters
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Source Code
```powershell
<#
.SYNOPSIS
	Lists installed CLI tools
.DESCRIPTION
	This PowerShell script lists installed command-line interface (CLI) tools.
.EXAMPLE
	PS> ./list-cli-tools

	Name         Version         Path                                          FileSize
	----         -------         ----                                          --------
	at           10.0.19041.1    C:\WINDOWS\system32\at.exe                    31232
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckFor { param([string]$Cmd, [string]$VersionArg)
	try {
		$Info = Get-Command $Cmd -ErrorAction Stop
		$Path = $Info.Source
		if ("$($Info.Version)" -eq "0.0.0.0") {
			if ("$VersionArg" -ne "") {
				$Result = invoke-expression "$Path $VersionArg"
				if ("$Result" -match '\d+.\d+\.\d+') {
					$Version = "$($Matches[0])"
				} elseif ("$Result" -match '\d+\.\d+') {
					$Version = "$($Matches[0])"
				} else {
					$Version = ""
				}
			} else {
				$Version = ""
			}
		} else {
			$Version = $Info.Version
		}
		if (Test-Path "$Path" -pathType leaf) {
			$FileSize = (Get-Item "$Path").Length
		} else {
			$FileSize = "0"
		}
		New-Object PSObject -Property @{ Name=$Cmd; Version=$Version; Path=$Path; FileSize=$FileSize }
	} catch {
		return
	}
}

function ListTools { 
	CheckFor 7z	"-version"
	CheckFor ant	"-v"
	CheckFor apt	"--version"
	CheckFor apt-get "--version"
	CheckFor amixer	"--version"
	CheckFor aplay	"--version"
	CheckFor ar	"--version"
	CheckFor arch	"--version"
	CheckFor arecord "--version"
	CheckFor arp    ""
	CheckFor at	""
	CheckFor attrib	""
	CheckFor awk	"--version"
	CheckFor b2sum	"--version"
	CheckFor base32	"--version"
	CheckFor base64	"--version"
	CheckFor basename "--version"
	CheckFor basenc	"--version"
	CheckFor bash	"--version"
	CheckFor bc		"--version"
	CheckFor bunzip2	"--version"
	CheckFor bzcat	"--version"
	CheckFor bzip2	"--version"
	CheckFor bzip2recover "--version"
	CheckFor captoinfo "--version"
	CheckFor cat	"-version"
	CheckFor cc		"--version"
	CheckFor chattr	"--version"
	CheckFor chcon	"--version"
	CheckFor chdsk	""
	CheckFor chgrp	"--version"
	CheckFor chmod	"--version"
	CheckFor chkntfs ""
	CheckFor chown	"--version"
	CheckFor chroot	"--version"
	CheckFor choco  "--version"
	CheckFor cipher ""
	CheckFor cksum	"--version"
	CheckFor clang	"--version"
	CheckFor clear	"--version"
	CheckFor cmake	"--version"
	CheckFor cmd	""
	CheckFor cmp	"--version"
	CheckFor column	"--version"
	CheckFor comp	""
	CheckFor compact ""
	CheckFor cp		"--version"
	CheckFor cpack	"--version"
	CheckFor csplit	"--version"
	CheckFor ctest	"--version"
	CheckFor curl	"--version"
	CheckFor cut	"--version"
	CheckFor cygcheck	"--version"
	CheckFor cygpath	"--version"
	CheckFor d2u	"--version"
	CheckFor dash	"--version"
	CheckFor date	""
	CheckFor dd		"--version"
	CheckFor df		"--version"
	CheckFor diff	"--version"
	CheckFor diff3	"--version"
	CheckFor dir	"--version"
	CheckFor dircolors "--version"
	CheckFor dirname	"--version"
	CheckFor dism	""
	CheckFor dos2unix	"--version"
	CheckFor driverquery ""
	CheckFor du		"--version"
	CheckFor echo	"--version"
	CheckFor egrep	"--version"
	CheckFor env	"--version"
	CheckFor ex		"--version"
	CheckFor expand	"--version"
	CheckFor expr	"--version"
	CheckFor factor	"--version"
	CheckFor false	"--version"
	CheckFor fido2-assert "--version"
	CheckFor fido2-cred   "--version"
	CheckFor fido2-token  "--version"
	CheckFor file	"--version"
	CheckFor find	"--version"
	CheckFor fgrep	"--version"
	CheckFor fmt	"--version"
	CheckFor fold	"--version"
	CheckFor ftp	"--version"
	CheckFor funzip	"--version"
	CheckFor gawk	"--version"
	CheckFor gencat	"--version"
	CheckFor getconf	"--version"
	CheckFor getopt	"--version"
	CheckFor gettext  "--version"
	CheckFor gcc	"--version"
	CheckFor gdb	"--version"
	CheckFor gh		"--version"
	CheckFor git	"--version"
	CheckFor gkill	"--version"
	CheckFor gmondump "--version"
	CheckFor gpg	"--version"
	CheckFor gpg-agent "--version"
	CheckFor gpgconf	"--version"
	CheckFor gpg-error "--version"
	CheckFor gpgsplit	"--version"
	CheckFor gpgtar	"--version"
	CheckFor grep	"--version"
	CheckFor groups	"--version"
	CheckFor gzip	"--version"
	CheckFor head	"--version"
	CheckFor hcsdiag ""
	CheckFor help	"--version"
	CheckFor hmac256	"--version"
	CheckFor hostid	"--version"
	CheckFor hostname ""
	CheckFor htop	"--version"
	CheckFor iconv	"--version"
	CheckFor id		"--version"
	CheckFor ipfs	"--version"
	CheckFor java	"--version"
	CheckFor join	"--version"
	CheckFor kill	"--version"
	CheckFor ldd	"--version"
	CheckFor less	"--version"
	CheckFor link	"--version"
	CheckFor ln	"--version"
	CheckFor locale	"--version"
	CheckFor locate	"--version"
	CheckFor logname	"--version"
	CheckFor ls	"--version"
	CheckFor lsattr	"--version"
	CheckFor lsb_release ""
	CheckFor lzma	"--version"
	CheckFor mac2unix "--version"
	CheckFor make	"--version"
	CheckFor md5sum "--version"
	CheckFor minidumper "--version"
	CheckFor mkdir	"--version"
	CheckFor mkfifo "--version"
	CheckFor mkgroup	"--version"
	CheckFor mknod	"--version"
	CheckFor mkpasswd "--version"
	CheckFor mktemp	"--version"
	CheckFor mount	"--version"
	CheckFor MpCmdRun "-h"
	CheckFor netsh  ""
	CheckFor netstat ""
	CheckFor nice	"--version"
	CheckFor nohup	"--version"
	CheckFor nroff	"--version"
	CheckFor nslookup ""
	CheckFor openssl ""
	CheckFor passwd	"--version"
	CheckFor paste	"--version"
	CheckFor perl	"--version"
	CheckFor ping	"-V"
	CheckFor ping6	"-V"
	CheckFor pip	"--version"
	CheckFor pip3	"--version"
	CheckFor pip3.8	"--version"
	CheckFor powercfg "/?"
	CheckFor powershell "--version"
	CheckFor print	""
	CheckFor printf "--version"
	CheckFor python "--version"
	CheckFor python3 "--version"
	CheckFor python3.8 "--version"
	CheckFor rasdial "--version"
	CheckFor regedit "--version"
	CheckFor replace "--version"
	CheckFor robocopy "--version"
	CheckFor route  ""
	CheckFor rsh	""
	CheckFor rsync	"--version"
	CheckFor rundll32 "--version"
	CheckFor scp	""
	CheckFor sftp	""
	CheckFor sh		"--version"
	CheckFor sha1sum "--version"
	CheckFor sha256sum "--version"
	CheckFor sha512sum "--version"
	CheckFor ssh	""
	CheckFor ssh-keygen ""
	CheckFor sort	"--version"
	CheckFor split	"--version"
	CheckFor strace	"--version"
	CheckFor strings "--version"
	CheckFor strip	"--version"
	CheckFor sudo	"--version"
	CheckFor systeminfo ""
	CheckFor tail	"--version"
	CheckFor tar	"--version"
	CheckFor taskkill ""
	CheckFor tasklist ""
	CheckFor tee	"--version"
	CheckFor time	""
	CheckFor timeout ""
	CheckFor top	"-v"
	CheckFor tskill ""
	CheckFor typeperf ""
	CheckFor tzsync "--version"
	CheckFor uniq	"--version"
	CheckFor vi	"--version"
	CheckFor vim	"--version"
	CheckFor vulkaninfo "--version"
	CheckFor w32tm  "/?"
	CheckFor waitfor "--version"
	CheckFor wakeonlan ""
	CheckFor wget	"--version"
	CheckFor where	"--version"
	CheckFor whatis "--version"
	CheckFor which	""
	CheckFor winget	"--version"
	CheckFor winsat ""
	CheckFor whoami "--version"
	CheckFor wput	"--version"
	CheckFor write	""
	CheckFor wsl	"--version"
	CheckFor xcopy	"--version"
	CheckFor yes	"--version"
	CheckFor zip	"--version"
	CheckFor zipcloak "--version"
	CheckFor zipdetails ""
	CheckFor zipgrep ""
	CheckFor zipinfo ""
	CheckFor zipnote ""
	CheckFor zipsplit ""
	CheckFor zsh	"--version"
}
 
try {
	ListTools | Format-Table -property @{e='Name';width=12},@{e='Version';width=15},@{e='Path';width=70},@{e='FileSize';width=10}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*Generated by convert-ps2md.ps1 using the comment-based help of list-cli-tools.ps1*
