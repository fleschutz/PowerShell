Collection of Useful PowerShell Scripts
=======================================

Useful cross-platform PowerShell scripts, to be used on the command-line (CLI) or by automation software like Jenkins.

Scripts Explained
-----------------
* **SHA256.ps1** - prints the SHA256 checksum of the given file
* **password.ps1** - generates and prints a single new password
* **passwords.ps1** - generates and prints a list of new passwords
* **poweroff.ps1** - halts the local computer, administrator rights might be needed
* **train_dns_cache.ps1** - trains the DNS cache with frequently used domain names
* **reboot.ps1** - reboots the local computer, administrator rights might be needed
* **speak.ps1** - speaks the given text
* **test.ps1** - simple test script
* **translate.ps1** - translates the given text
* **txt2wav.ps1** - converts text into a audio .WAV file
* **wakeup.ps1** - sends a magic packet to the given computer, waking him up

Frequently Asked Questions (FAQ)
--------------------------------
**What is PowerShell?**

PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 
* PowerShell is cross-platform: available for Windows, Linux and Mac OS
* PowerShell is powerful: fully control your computer
* PowerShell is open-source: see the Github repository at https://github.com/PowerShell/PowerShell 
* PowerShell is easy to learn: see the tutorial at https://www.guru99.com/powershell-tutorial.html
* PowerShell is fully documented: see the official docs at https://docs.microsoft.com/en-us/powershell/

**How to configure PowerShell as default shell on Linux?**

Make sure PowerShell is installed, then use the `chsh` as follows:
* `chsh -s /bin/powershell username`

**How to add the subfolder Scripts/ to the search path for command-line usage?**

* **Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"
* **Bash or sh:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"

Script Standards
----------------
Each script provides:
1. a comment header containing the description, author, source, and license
2. prefers command-line options but may ask the user in case no option is given
3. exits 0 for success, otherwise the error code (mostly 1)

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
