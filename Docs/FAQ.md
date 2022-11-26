PowerShell FAQ
==============

What is PowerShell?
-------------------
PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 


Why use PowerShell?
-------------------
✔️ it's **powerful** - fully control your computer

✔️ it's **cross-platform** - available for Linux, Mac OS and Windows

✔️ it's **open-source and free** - see the Github repository at: https://github.com/PowerShell/PowerShell 

✔️ it's **easy to learn** - see the tutorial for beginners at: https://www.guru99.com/powershell-tutorial.html

✔️ it's **fully documented** - see the PowerShell documentation at: https://docs.microsoft.com/en-us/powershell/


How to install PowerShell?
--------------------------
* **On Windows** it's preinstalled. **However,** the execution policy is 'restricted' by default! To allow script execution: open the *Windows PowerShell (Administrator)* console and enter:
   ```
   PS> Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
   ```
* **On CentOS, Debian, Docker, Fedora, macOS, openSUSE, Red Hat, Ubuntu** visit https://github.com/PowerShell/PowerShell for installation.
* **On Linux supporting Snaps** install PowerShell by executing:
   ```
   $ snap install PowerShell
   $ ln -s /snap/bin/pwsh /usr/bin/pwsh
   ```

How to get the PowerShell Scripts?
----------------------------------
* When using **Git**, execute in a terminal window: `> git clone https://github.com/fleschutz/PowerShell`
* When using **Chocolatey**, execute in *Windows PowerShell (Administrator)*: `> choco install powershell-scripts --version=0.4`
* **Otherwise,** download and unzip it from: https://github.com/fleschutz/PowerShell/archive/master.zip


How to execute PowerShell Scripts?
----------------------------------
1. In the Windows desktop: right-click the script and select: *Execute with PowerShell*
2. In a command-line interface (CLI, e.g. *Windows Terminal*, either local or remote via SSH) by typing: `./<FILENAME_OF_SCRIPT>`.
3. By connecting a context menu item with a script.
4. By voice control, e.g. see repo [talk2windows](https://github.com/fleschutz/talk2windows) for more information.
5. By using automation software, e.g. [Jenkins](https://www.jenkins.io).
6. Automatically on login (see AutoStart folder)/logoff/daily/etc.


What about Security?
--------------------
* Execute scripts only that you trust (and/or where you have checked the code before)!
* Prefer SSH Remoting instead of PowerShell Remoting
* More recommendations by NSA and cyber security centers in the U.S. (CISA), New Zealand (NZ NCSC), and the U.K. (NCSC-UK) can be found here: https://media.defense.gov/2022/Jun/22/2003021689/-1/-1/1/CSI_KEEPING_POWERSHELL_SECURITY_MEASURES_TO_USE_AND_EMBRACE_20220622.PDF


Why do some scripts show gibberish characters?
----------------------------------------------
Those PowerShell scripts are using Unicode characters. Use a modern console supporting UTF-8 such as *Windows Terminal*, please.


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
Good PowerShell scripts are user-friendly and platform-independent. The following rules should be a good starting point:

1. Use the `<verb>-<object>.ps1` scheme to name the script.
2. Use `UTF-8 BOM` encoding to support Unicode characters in the script.
3. Add a comment-based help at the beginning with: `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`, `.LINK`, and `.NOTES`.
4. Check the requirements for the script, e.g. `#Requires -RunAsAdministrator`, or `#Requires -Version 3`
5. Prefer command-line options, else ask the user for help
6. Recommended is `Set-StrictMode -Version Latest` to enable additional error checking.
7. For readibility use UpperCamelCase for variables and functions, lowerCamelCase for everything else.
8. Set *execute* file permissions for Linux: `chmod a+rx <filename>`
9. On success exit with error code 0 (`exit 0`), otherwise print the error with keyword "ERROR:" (to support log parsers) and exit the error code (mostly 1)


Want to contribute or found a bug or issue?
-------------------------------------------
If you find something bad (like a bug, error, or any issue), please report it here by open an Issue.

Or even better: Fork the repository, add or fix the script and submit a pull request, so others can participate too.  


Your question is not answered here?
-----------------------------------
Send your question to: markus [at] fleschutz [dot] de
