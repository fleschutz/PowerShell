Collection of Useful PowerShell Scripts (CUPS)
==============================================

Useful cross-platform PowerShell scripts, to be used on the command-line (CLI) or by automation software like Jenkins.

PowerShell Scripts Included
---------------------------
* **exe_info.ps1** - prints basic information of the given executable file
* **lscmdlets.ps1** - lists all PowerShell cmdlets
* **lsmods.ps1** - lists all PowerShell modules
* **lsproc.ps1** - lists the local computer processes
* **MD5.ps1** - prints the MD5 checksum of the given file
* **moon.ps1** - prints the current moon phase
* **password.ps1** - generates and prints a single new password
* **passwords.ps1** - generates and prints a list of new passwords
* **poweroff.ps1** - halts the local computer, administrator rights might be needed
* **news.ps1** - print the latest news
* **reboot.ps1** - reboots the local computer, administrator rights might be needed
* **SHA1.ps1** - prints the SHA1 checksum of the given file
* **SHA256.ps1** - prints the SHA256 checksum of the given file
* **speak.ps1** - speaks the given text
* **test.ps1** - simple test script
* **train_dns_cache.ps1** - trains the DNS cache with frequently used domain names
* **translate.ps1** - translates the given text
* **txt2wav.ps1** - converts text into a audio .WAV file
* **weather.ps1** - prints the current weather forecast
* **wakeup.ps1** - sends a magic packet to the given computer, waking him up
* **zipdir.ps1** - creates a zip archive of the given folder

What is PowerShell?
-------------------

PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 
* it's **cross-platform**: available for Linux, Mac OS and Windows
* it's **powerful**: fully control your computer
* it's **open-source**: see the Github repository at https://github.com/PowerShell/PowerShell 
* it's **easy to learn**: see the tutorial at https://www.guru99.com/powershell-tutorial.html
* it's **fully documented**: see the official docs at https://docs.microsoft.com/en-us/powershell/

How to get PowerShell?
----------------------
Windows 7 and newer do provide PowerShell by default. It's recommended to use it via **Windows Terminal** (see the Microsoft Store at https://www.aka.ms/terminal).

For installation on alternative platforms (CentOS, Debian, Docker, Fedora, macOS, openSUSE, Red Hat, Ubuntu) visit https://github.com/PowerShell/PowerShell.

Afterward, install the scripts by clicking on the green "Code" button or execute:
```
$ git clone https://github.com/fleschutz/PowerShell
```

How to configure PowerShell as default shell on Linux?
------------------------------------------------------

Make sure PowerShell is installed, then use the `chsh` commmand as follows:
* `chsh -s /bin/powershell <username>`


How to add the subfolder Scripts/ to the search path for command-line usage?
----------------------------------------------------------------------------

* **Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"
* **Bash or sh:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"

Script Standards
----------------
Each script provides:
1. a comment header containing the syntax, description, author, source, and license
2. prefers command-line options but may ask the user in case no option is given
3. exits 0 for success, otherwise the error code (mostly 1)

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
