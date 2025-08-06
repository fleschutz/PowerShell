The *list-cli-tools.ps1* Script
===========================

list-cli-tools.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Lists command-line tools
.DESCRIPTION
	This PowerShell script lists installed command-line interface (CLI) tools (sorted alphabetically by name).
.EXAMPLE
	PS> ./list-cli-tools.ps1

	NAME      VERSION           PATH
	----      -------           ----
	arp       10.0.22621.4111   C:\Windows\system32\ARP.EXE (45K)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function Bytes2String([int64]$bytes) {
        if ($bytes -lt 1000) { return "$bytes bytes" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)K" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)MB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)GB" }
        $bytes /= 1000
        return "$($Bytes)TB"
}

function ListTool([string]$Name, [string]$VersionArg) {
	try {
		$Info = Get-Command $Name -ErrorAction Stop
		$Path = $Info.Source
		if ("$($Info.Version)" -eq "0.0.0.0") {
			if ("$VersionArg" -ne "") {
				$Result = Invoke-Expression "$Path $VersionArg"
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
			$Size = (Get-Item "$Path").Length
		} else {
			$Size = 0
		}
		New-Object PSObject -Property @{ 'NAME'=$Name; 'VERSION'=$Version; 'PATH'="$Path ($(Bytes2String $Size))" }
	} catch {
		return
	}
}

function List-CLI-Tools {
	ListTool 7z		"-version"
	ListTool ant		"-v"
	ListTool apt		"--version"
	ListTool apt-get	"--version"
	ListTool amixer		"--version"
	ListTool aplay		"--version"
	ListTool apropos	"--version"
	ListTool ar		"--version"
	ListTool arch		"--version"
	ListTool arecord	"--version"
	ListTool arp		"--version"
	ListTool at		""
	ListTool attrib		""
	ListTool auditpol       ""
	ListTool awk		"--version"
	ListTool b2sum		"--version"
	ListTool base32		"--version"
	ListTool base64		"--version"
	ListTool basename	"--version"
	ListTool basenc		"--version"
	ListTool bash		"--version"
	ListTool bc		"--version"
	ListTool bcdboot        ""
	ListTool bcdedit	""
	ListTool bitsadmin      ""
	ListTool bunzip2	"--version"
	ListTool bzcat		"--version"
	ListTool bzip2		"--version"
	ListTool bzip2recover	"--version"
	ListTool captoinfo	"-V"
	ListTool cat		"--version"
	ListTool cc		"--version"
	ListTool certutil       "/?"
	ListTool chattr		"--help"
	ListTool chcon		"--version"
	ListTool chcpu		"--version"
	ListTool chdsk		""
	ListTool chglogon       ""
	ListTool chgport        ""
	ListTool chgusr         ""
	ListTool chgrp		"--version"
	ListTool chmod		"--version"
	ListTool chkntfs	""
	ListTool chmem		"--version"
	ListTool choice         "/?"
	ListTool chown		"--version"
	ListTool chpasswd	"--help"
	ListTool chroot		"--version"
	ListTool choco		"--version"
	ListTool cipher		""
	ListTool cksum		"--version"
	ListTool clang		"--version"
	ListTool clear		"-V"
	ListTool cmake		"--version"
	ListTool cmd		""
	ListTool cmdkey         "/list"
	ListTool cmp		"--version"
	ListTool column		"--version"
	ListTool comp		""
	ListTool compact	""
	ListTool cp		"--version"
	ListTool cpack		"--version"
	ListTool cscript        ""
	ListTool csplit		"--version"
	ListTool ctest		"--version"
	ListTool curl		"--version"
	ListTool curl.exe       "--version"
	ListTool cut		"--version"
	ListTool cygcheck	"--version"
	ListTool cygpath	"--version"
	ListTool d2u		"--version"
	ListTool dash		"--version"
	ListTool date		""
	ListTool dd		"--version"
	ListTool defrag.exe	"/?"
	ListTool delgroup	"--version"
	ListTool deluser	"--version"
	ListTool df		"--version"
	ListTool diff		"--version"
	ListTool diff3		"--version"
	ListTool difft		"--version"
	ListTool dir		"--version"
	ListTool dircolors	"--version"
	ListTool dirname	"--version"
	ListTool dism		""
	ListTool dmidecode	"--version"
	ListTool dos2unix	"--version"
	ListTool doskey         "/?"
	ListTool dotnet         "--info"
	ListTool driverquery	""
	ListTool du		"--version"
	ListTool echo		"--version"
	ListTool edit.exe	"--version"
	ListTool egrep		"--version"
	ListTool emacs		"--version"
	ListTool env		"--version"
	ListTool eventcreate    "/?"
	ListTool ex		"--version"
	ListTool expand		"--version"
	ListTool expr		"--version"
	ListTool factor		"--version"
	ListTool false		"--version"
	ListTool fido2-assert	"--version"
	ListTool fido2-cred	"--version"
	ListTool fido2-token	"--version"
	ListTool file		"--version"
	ListTool find		"--version"
	ListTool fish		"--version"
	ListTool fgrep		"--version"
	ListTool fmt		"--version"
	ListTool fold		"--version"
	ListTool ftp		"-?"
	ListTool funzip		"-version"
	ListTool gawk		"--version"
	ListTool gencat		"--version"
	ListTool getconf	"--version"
	ListTool getopt		"--version"
	ListTool gettext	"--version"
	ListTool gcc		"--version"
	ListTool gdb		"--version"
	ListTool gh		"--version"
	ListTool git		"--version"
	ListTool gkill		"--version"
	ListTool gmondump	"--version"
	ListTool go		"version"
	ListTool gpg		"--version"
	ListTool gpg-agent	"--version"
	ListTool gpgconf	"--version"
	ListTool gpg-error	"--version"
	ListTool gpgsplit	"--version"
	ListTool gpgtar		"--version"
	ListTool gradle		"--version"
	ListTool grep		"--version"
	ListTool groups		"--version"
	ListTool gzip		"--version"
	ListTool head		"--version"
	ListTool hcsdiag	""
	ListTool help		"--version"
	ListTool hmac256	"--version"
	ListTool hostid		"--version"
	ListTool hostname	""
	ListTool htop		"--version"
	ListTool hx		"--version" # Helix editor
	ListTool icacls		"--version"
	ListTool iconv		"--version"
	ListTool id		"--version"
	ListTool ip		"help"
	ListTool ipfs		"--version"
	ListTool java		"--version"
	ListTool jcli		"version"
	ListTool join		"--version"
	ListTool jhead		"-V"
	ListTool kill		"--version"
	ListTool ldd		"--version"
	ListTool less		"--version"
	ListTool link		"--version"
	ListTool ln		"--version"
	ListTool locale		"--version"
	ListTool locate		"--version"
	ListTool logname	"--version"
	ListTool ls		"--version"
	ListTool lsattr		"-V"
	ListTool lsb_release	""
	ListTool lzma		"--version"
	ListTool mac2unix	"--version"
	ListTool make		"--version"
	ListTool mbr2gpt	""
	ListTool md5sum		"--version"
	ListTool minidumper	"--version"
	ListTool mkdir		"--version"
	ListTool mkfifo		"--version"
	ListTool mkgroup	"--version"
	ListTool mknod		"--version"
	ListTool mkpasswd	"--version"
	ListTool mktemp		"--version"
	ListTool mount		"--version"
	ListTool MpCmdRun	"-h"
	ListTool msedit		"--version"
	ListTool nano		"--version"
	ListTool netsh		""
	ListTool netstat	""
	ListTool nice		"--version"
	ListTool nmap		"--version"
	ListTool nohup		"--version"
	ListTool nroff		"--version"
	ListTool nslookup	""
	ListTool openssl	""
	ListTool pandoc		"--version"
	ListTool passwd		"--status"
	ListTool paste		"--version"
	ListTool perl		"--version"
	ListTool ping		"-V"
	ListTool ping6		"-V"
	ListTool pip		"--version"
	ListTool pip3		"--version"
	ListTool pip3.8		"--version"
	ListTool pnputil	"/?"
	ListTool powercfg	"/?"
	ListTool powershell	"--version"
	ListTool print		""
	ListTool printf		"--version"
	ListTool pro		"--version"
	ListTool python		"--version"
	ListTool python3	"--version"
	ListTool python3.8	"--version"
	ListTool rasdial	"--version"
	ListTool regedit	"--version"
	ListTool replace	"--version"
	ListTool robocopy	"--version"
	ListTool route		""
	ListTool rpcping        ""
	ListTool rsh		""
	ListTool rsync		"--version"
	ListTool rundll32	"--version"
	ListTool sc.exe		"/?"
	ListTool scp		""
	ListTool setx           ""
	ListTool sftp		""
	ListTool sh		"--version"
	ListTool sha1sum	"--version"
	ListTool sha256sum	"--version"
	ListTool sha512sum	"--version"
	ListTool ssh		"-V"
	ListTool ssh-keygen	""
	ListTool smartctl	"--version"
	ListTool sort		"--version"
	ListTool split		"--version"
	ListTool strace		"--version"
	ListTool strings	"--version"
	ListTool strip		"--version"
	ListTool sudo		"--version"
	ListTool syncthing	"--version"
	ListTool systeminfo	""
	ListTool tail		"--version"
	ListTool tar		"--version"
	ListTool taskkill	""
	ListTool tasklist	""
	ListTool tcpdump	"--version"
	ListTool tee		"--version"
	ListTool terraform	"--version"
	ListTool time		""
	ListTool timeout	""
	ListTool top		"--version"
	ListTool tracert	""
	ListTool tskill		""
	ListTool typeperf	""
	ListTool tzsync		"--version"
	ListTool unbound	"-V"
	ListTool uniq		"--version"
	ListTool vi		"--version"
	ListTool vim		"--version"
	ListTool vlc		"--version"
	ListTool vssadmin       "/?"
	ListTool vulkaninfo	"--version"
	ListTool w32tm		"/?"
	ListTool waitfor	"--version"
	ListTool wakeonlan	"-v"
	ListTool wget		"--version"
	ListTool where		"--version"
	ListTool whatis		"--version"
	ListTool which		""
	ListTool winget		"--version"
	ListTool winsat		""
	ListTool whoami		"--version"
	ListTool wput		"--version"
	ListTool write		""
	ListTool wsl		"--version"
	ListTool xcopy		"--version"
	ListTool yes		"--version"
	ListTool zig		"--version"
	ListTool zip		"--version"
	ListTool zipcloak	"--version"
	ListTool zipdetails	""
	ListTool zipgrep	""
	ListTool zipinfo	""
	ListTool zipnote	""
	ListTool zipsplit	""
	ListTool zsh		"--version"
	ListTool zstd		"--version"
	ListTool zvm		"--version"
}
 
try {
	List-CLI-Tools | Format-Table -property @{e='NAME';width=15},@{e='VERSION';width=16},@{e='PATH';width=90}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/06/2025 15:18:22)*
