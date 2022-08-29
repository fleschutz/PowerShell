PowerShell FAQ
==============

What is PowerShell?
-------------------
PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 


Why use PowerShell?
-------------------
✔️ it's **powerful** - fully control your computer

✔️ it's **cross-platform** - available for Linux, Mac OS and Windows

✔️ it's **open-source and free** - see the Github repository at https://github.com/PowerShell/PowerShell 

✔️ it's **easy to learn** - see the tutorial for beginners at https://www.guru99.com/powershell-tutorial.html

✔️ it's **fully documented** - see the PowerShell documentation at https://docs.microsoft.com/en-us/powershell/


How to get PowerShell?
----------------------
* **Windows 7/Server 2008 R2 and newer** already have PowerShell preinstalled. However, script execution is **disallowed by default** (execution policy is "restricted"). To enable it: open the "Windows PowerShell (Administrator)" console and enter:
   ```
   PS> Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
   ```
* **On CentOS, Debian, Docker, Fedora, macOS, openSUSE, Red Hat, Ubuntu** visit https://github.com/PowerShell/PowerShell for installation.
* **On Linux supporting Snaps** install PowerShell by executing:
   ```
   $ snap install PowerShell
   $ ln -s /snap/bin/pwsh /usr/bin/pwsh
   ```

What about Security?
--------------------
* Execute scripts only that you trust (and/or where you have checked the code before)!
* Prefer SSH Remoting instead of PowerShell Remoting
* More recommendations by NSA and cyber security centers in the U.S. (CISA), New Zealand (NZ NCSC), and the U.K. (NCSC-UK) can be found here: https://media.defense.gov/2022/Jun/22/2003021689/-1/-1/1/CSI_KEEPING_POWERSHELL_SECURITY_MEASURES_TO_USE_AND_EMBRACE_20220622.PDF


How to get the PowerShell Scripts?
----------------------------------
* When using Git: execute `> git clone https://github.com/fleschutz/PowerShell` in a terminal window.
* When using Chocolatey: execute `> choco install powershell-scripts --version=0.4` in a terminal window.
* Otherwise, download and unzip from: https://github.com/fleschutz/PowerShell/archive/master.zip


Why do some scripts show gibberish characters?
----------------------------------------------
Those PowerShell scripts are using Unicode characters. Use a modern console supporting UTF-8 such as Windows Terminal, please.


How to set PowerShell as default shell on Linux?
------------------------------------------------
Make sure PowerShell is installed, then execute: `chsh -s /usr/bin/pwsh <username>`. In case you experience an "invalid shell" error, add "/usr/bin/pwsh" to /etc/shells.


How to add the scripts to the search path?
------------------------------------------
Want to use the PowerShell scripts everywhere on the command-line? Then you need to add the Scripts/ subfolder to the search path:

* **On Linux using Bash:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **On Windows:** open Settings > System > About > Advanced system settings > Environment Variables, edit the user's variable "Path", and add the full path to the Scripts/ directory.


How to use PowerShell in Windows context menus?
-----------------------------------------------
* to enable "right-click > New > Windows PowerShell Script" execute `Add_ps1_to_New_context_menu.reg` in subfolder [Data/](../Data)
* to disable this execute `Remove_ps1_from_New_context_menu.reg` in subfolder [Data/](../Data)


Which editor to use for PowerShell scripts?
-------------------------------------------
* **Visual Studio Code** - Supporting syntax highlighting, on-the-fly problem checking and an integrated PowerShell Console (available for free on Linux, Mac OS and Windows, now recommended by Microsoft).
* **PowerShell ISE** (Integrated Scripting Environment) - Former official PowerShell development environment included with Microsoft Windows.
* **PowerShell Studio** - Powerful PowerShell IDE with module, help, and user interface development tools, high DPI support and regular updates.
* **PowerShell Plus** - All in one IDE.
* **Atom package** - Add-on with PowerShell language support for Atom.
* **SublimeText package** - Add-on with PowerShell language support for Sublime Text.
* or your **favorite text editor** as an alternative.


How to write good PowerShell scripts?
-------------------------------------
Good PowerShell scripts are user-friendly and platform-independant. As a guideline follow these rules, please:

1. the filename is named using the `<verb>-<object>.ps1` scheme
2. the encoding is UTF-8-BOM to provide Unicode character support
3. the scripts have execute file permissions: chmod a+rx <file> (for Linux support)
4. the scripts provide a comment-based help with synopsis, description, parameters, link, author, and license
5. requirements are checked (e.g. #Requires -RunAsAdministrator, or #Requires -Version 3)
6. prefer command-line options, else ask the user for help
7. recommended is `Set-StrictMode -Version Latest` to enable additional error checking
8. for readibility use UpperCamelCase for variables and functions, lowerCamelCase for everything else
9. on error call write-error with keyword "ERROR:" (to support log parsers) and exit the error code (mostly 1)
10. on success exit with error code 0 (exit 0)


Want to contribute or found a bug or issue?
-------------------------------------------
If you find something bad (like a bug, error, or any issue), please report it here by open an Issue.

Or even better: Fork the repository, add or fix the script and submit a pull request, so others can participate too.  


Your question is not answered here?
-----------------------------------
Send your question to: markus [at] fleschutz [dot] de
