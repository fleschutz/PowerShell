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

function CheckFor { param([string]$Cmd)
	try {
		$Info = Get-Command $Cmd -ErrorAction Stop
		$Location = $Info.Source
		if (test-path "$Location" -pathType leaf) {
			$FileSize = (Get-Item "$Location").Length
		} else {
			$FileSize = "0"
		}
		new-object PSObject -Property @{ Name=$Cmd; Version=$Info.Version; Location=$Location; FileSize=$FileSize }
	} catch {
		return
	}
}

function ListTools { 
	CheckFor 7z
	CheckFor ant
	CheckFor apt
	CheckFor apt-get
	CheckFor amixer
	CheckFor aplay
	CheckFor ar
	CheckFor arecord
	CheckFor at
	CheckFor awk
	CheckFor basename
	CheckFor bash
	CheckFor bc
	CheckFor cc
	CheckFor cksum
	CheckFor clang
	CheckFor curl
	CheckFor cut
	CheckFor diff
	CheckFor find
	CheckFor ftp
	CheckFor gcc
	CheckFor gdb
	CheckFor git
	CheckFor gpg
	CheckFor help
	CheckFor ipfs
	CheckFor java
	CheckFor lsb_release
	CheckFor lzma
	CheckFor make
	CheckFor md5sum
	CheckFor mkfifo
	CheckFor nice
	CheckFor nroff
	CheckFor nslookup
	CheckFor openssl
	CheckFor perl
	CheckFor ping
	CheckFor ping6
	CheckFor printf
	CheckFor python
	CheckFor regedit
	CheckFor replace
	CheckFor robocopy
	CheckFor rsh
	CheckFor rsync
	CheckFor rundll32
	CheckFor scp
	CheckFor sftp
	CheckFor sha1sum
	CheckFor sha256sum
	CheckFor sha512sum
	CheckFor ssh
	CheckFor ssh-keygen
	CheckFor sort
	CheckFor split
	CheckFor strace
	CheckFor strings
	CheckFor strip
	CheckFor sudo
	CheckFor tail
	CheckFor tar
	CheckFor tasklist
	CheckFor tee
	CheckFor time
	CheckFor top
	CheckFor tskill
	CheckFor tzsync
	CheckFor uniq
	CheckFor vi
	CheckFor vim
	CheckFor vulkaninfo
	CheckFor waitfor
	CheckFor wakeonlan
	CheckFor wget
	CheckFor where
	CheckFor whatis
	CheckFor which
	CheckFor whoami
	CheckFor wput
	CheckFor write
	CheckFor xcopy
	CheckFor yes
	CheckFor zip
	CheckFor zipcloak
	CheckFor zipdetails
	CheckFor zipgrep
	CheckFor zipinfo
	CheckFor zipnote
	CheckFor zipsplit
	CheckFor zsh
}
 
try {
	ListTools | format-table -property @{e='Name';width=12},@{e='Version';width=13},@{e='Location';width=45},@{e='FileSize';width=10}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
