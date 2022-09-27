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
	CheckFor arecord "--version"
	CheckFor at	""
	CheckFor attrib	""
	CheckFor awk	"--version"
	CheckFor basename "--version"
	CheckFor bash	"--version"
	CheckFor bc	"--version"
	CheckFor cc	"--version"
	CheckFor chdsk	""
	CheckFor chkntfs ""
	CheckFor choco  "--version"
	CheckFor cipher ""
	CheckFor cksum	"--version"
	CheckFor clang	"--version"
	CheckFor cmake	"--version"
	CheckFor cmd	""
	CheckFor comp	""
	CheckFor compact ""
	CheckFor cpack	"--version"
	CheckFor ctest	"--version"
	CheckFor curl	"--version"
	CheckFor cut	"--version"
	CheckFor date	""
	CheckFor diff	"--version"
	CheckFor dism	""
	CheckFor driverquery ""
	CheckFor egrep	"--version"
	CheckFor find	"--version"
	CheckFor fgrep	"--version"
	CheckFor ftp	"--version"
	CheckFor gcc	"--version"
	CheckFor gdb	"--version"
	CheckFor gh	"--version"
	CheckFor git	"--version"
	CheckFor gpg	"--version"
	CheckFor hcsdiag ""
	CheckFor help	"--version"
	CheckFor hostname ""
	CheckFor htop	"--version"
	CheckFor ipfs	"--version"
	CheckFor java	"--version"
	CheckFor lsb_release ""
	CheckFor lzma	"--version"
	CheckFor make	"--version"
	CheckFor md5sum "--version"
	CheckFor mkfifo "--version"
	CheckFor mount	"--version"
	CheckFor MpCmdRun "-h"
	CheckFor nice	"--version"
	CheckFor nroff	"--version"
	CheckFor nslookup ""
	CheckFor openssl ""
	CheckFor perl	"--version"
	CheckFor ping	"-V"
	CheckFor ping6	"-V"
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
	CheckFor rsh	""
	CheckFor rsync	"--version"
	CheckFor rundll32 "--version"
	CheckFor scp	""
	CheckFor sftp	""
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