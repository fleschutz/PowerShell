<#
.SYNOPSIS
	list-cli-tools.ps1
.DESCRIPTION
	Lists available command-line interface (CLI) tools 
.EXAMPLE
	PS> .\list-cli-tools.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function CheckFor { param([string]$Cmd, [string]$VersionArg)
	try {
		$Info = Get-Command $Cmd -ErrorAction Stop
		$Location = $Info.Source
		if ("$($Info.Version)" -eq "0.0.0.0") {
			if ("$VersionArg" -ne "") {
				$Result = invoke-expression "$Location $VersionArg"
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
		if (test-path "$Location" -pathType leaf) {
			$FileSize = (Get-Item "$Location").Length
		} else {
			$FileSize = "0"
		}
		new-object PSObject -Property @{ Name=$Cmd; Version=$Version; Location=$Location; FileSize=$FileSize }
	} catch {
		return
	}
}

function ListTools { 
	CheckFor 7z "-version"
	CheckFor ant "-v"
	CheckFor apt "--version"
	CheckFor apt-get "--version"
	CheckFor amixer "--version"
	CheckFor aplay "--version"
	CheckFor ar "--version"
	CheckFor arecord "--version"
	CheckFor at ""
	CheckFor attrib ""
	CheckFor awk "--version"
	CheckFor basename "--version"
	CheckFor bash "--version"
	CheckFor bc "--version"
	CheckFor cc "--version"
	CheckFor chdsk ""
	CheckFor chkntfs ""
	CheckFor cipher ""
	CheckFor cksum "--version"
	CheckFor clang "--version"
	CheckFor cmake "--version"
	CheckFor cmd ""
	CheckFor comp ""
	CheckFor compact ""
	CheckFor cpack "--version"
	CheckFor ctest "--version"
	CheckFor curl "--version"
	CheckFor cut "--version"
	CheckFor date ""
	CheckFor diff "--version"
	CheckFor driverquery ""
	CheckFor find "--version"
	CheckFor ftp "--version"
	CheckFor gcc "--version"
	CheckFor gdb "--version"
	CheckFor git "--version"
	CheckFor gpg "--version"
	CheckFor help "--version"
	CheckFor hostname ""
	CheckFor htop "--version"
	CheckFor ipfs "--version"
	CheckFor java "--version"
	CheckFor lsb_release ""
	CheckFor lzma "--version"
	CheckFor make "--version"
	CheckFor md5sum "--version"
	CheckFor mkfifo "--version"
	CheckFor nice "--version"
	CheckFor nroff "--version"
	CheckFor nslookup ""
	CheckFor openssl ""
	CheckFor perl "--version"
	CheckFor ping "-V"
	CheckFor ping6 "-V"
	CheckFor print ""
	CheckFor printf "--version"
	CheckFor python "--version"
	CheckFor regedit "--version"
	CheckFor replace "--version"
	CheckFor robocopy "--version"
	CheckFor rsh ""
	CheckFor rsync "--version"
	CheckFor rundll32 "--version"
	CheckFor scp ""
	CheckFor sftp ""
	CheckFor sha1sum "--version"
	CheckFor sha256sum "--version"
	CheckFor sha512sum "--version"
	CheckFor ssh ""
	CheckFor ssh-keygen ""
	CheckFor sort "--version"
	CheckFor split "--version"
	CheckFor strace "--version"
	CheckFor strings "--version"
	CheckFor strip "--version"
	CheckFor sudo "--version"
	CheckFor systeminfo ""
	CheckFor tail "--version"
	CheckFor tar "--version"
	CheckFor taskkill ""
	CheckFor tasklist ""
	CheckFor tee "--version"
	CheckFor time ""
	CheckFor timeout ""
	CheckFor top "-v"
	CheckFor tskill ""
	CheckFor tzsync "--version"
	CheckFor uniq "--version"
	CheckFor vi "--version"
	CheckFor vim "--version"
	CheckFor vulkaninfo "--version"
	CheckFor waitfor "--version"
	CheckFor wakeonlan ""
	CheckFor wget "--version"
	CheckFor where "--version"
	CheckFor whatis "--version"
	CheckFor which ""
	CheckFor whoami "--version"
	CheckFor wput "--version"
	CheckFor write ""
	CheckFor wsl ""
	CheckFor xcopy "--version"
	CheckFor yes "--version"
	CheckFor zip "--version"
	CheckFor zipcloak "--version"
	CheckFor zipdetails ""
	CheckFor zipgrep ""
	CheckFor zipinfo ""
	CheckFor zipnote ""
	CheckFor zipsplit ""
	CheckFor zsh "--version"
}
 
try {
	ListTools | format-table -property @{e='Name';width=12},@{e='Version';width=15},@{e='Location';width=45},@{e='FileSize';width=10}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
