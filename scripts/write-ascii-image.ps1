<#
.SYNOPSIS
        Writes an ASCII image
.DESCRIPTION
        This PowerShell script writes an ASCII image to the console.
.EXAMPLE
        PS> .\write-ascii-image.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function WriteLine([string]$line) {
	Write-Host $line -foregroundColor green
}

WriteLine ""
WriteLine "              _-o#&&*''''?d:>b\_"
WriteLine "          _o/'`''  '',, dMF9MMMMMHo_"
WriteLine "       .o&#'        `'MbHMMMMMMMMMMMHo."
WriteLine "     .o'' '         vodM*S&&HMMMMMMMMMM?."
WriteLine "    ,'              SM&ood,~'`(&##MMMMMMH\"
WriteLine "   /               ,MMMMMMM#b?#bobMMMMHMMML"
WriteLine "  &              ?MMMMMMMMMMMMMMMMM7MMMSR*Hk"
WriteLine " ?S.            :MMMMMMMMMMMMMMMMMMM/HMMM|`*L"
WriteLine "|               |MMMMMMMMMMMMMMMMMMMMbMH'   T,"
WriteLine "SH#:            `*MMMMMMMMMMMMMMMMMMMMb#}'  `?"
WriteLine "]MMH#             ''*''''*#MMMMMMMMMMMMM'    -"
WriteLine "MMMMMb_                   |MMMMMMMMMMMP'     :"
WriteLine "HMMMMMMMHo                 `MMMMMMMMMT       ."
WriteLine "?MMMMMMMMP                  9MMMMMMMM}       -"
WriteLine "-?MMMMMMM                  |MMMMMMMMM?,d-    '"
WriteLine " :|MMMMMM-                 `MMMMMMMT .M|.   :"
WriteLine "  .9MMM[                    &MMMMM*' `'    ."
WriteLine "   :9MMk                    `MMM#'        -"
WriteLine "     &M}                     '          .-"
WriteLine "      `&.                             ."
WriteLine "        `~,   .                     ./"
WriteLine "            . _                  .-"
WriteLine "              '`--._,dd###pp='''"
exit 0 # success
