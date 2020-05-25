Collection of PowerShell Scripts
================================

Useful cross-platform PowerShell scripts, to be used on the command-line (CLI) or by automation software like Jenkins.

PowerShell Scripts
------------------
* **password.ps1** - generates and prints a single new password
* **passwords.ps1** - generates and prints a list of new passwords
* **poweroff.ps1** - halts the local computer, administrator rights might be needed
* **reboot.ps1** - reboots the local computer, administrator rights might be needed
* **speak.ps1** - speaks the given text
* **translate.ps1** - translates the given text
* **txt2wav.ps1** - converts text into a audio .WAV file
* **wakeup.ps1** - sends a magic packet to the given computer, waking him up

What is PowerShell?
-------------------
PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 
* PowerShell is cross-platform: available for Windows, Linux and Mac OS
* PowerShell is powerful: fully control your computer
* PowerShell is open-source: see the repository at https://github.com/PowerShell/PowerShell 
* PowerShell is easy to learn: see the tutorial at https://www.guru99.com/powershell-tutorial.html
* PowerShell is fully documented: see the official docs at https://docs.microsoft.com/en-us/powershell/

Script Standards
----------------
Each script provides:
1. a comment header containing a description, author, source, and license
2. prefers command-line options but may ask the user if missing
3. exits 0 for success, otherwise the error code (mostly 1)

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
