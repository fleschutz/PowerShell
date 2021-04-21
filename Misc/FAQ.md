PowerShell FAQ
==============

What is PowerShell?
-------------------
PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. 

Why use PowerShell?
-------------------
* **it's powerful**: fully control your computer
* **it's cross-platform**: available for Linux, Mac OS and Windows
* **it's open-source and free**: see the Github repository at https://github.com/PowerShell/PowerShell 
* **it's easy to learn**: see the tutorial at https://www.guru99.com/powershell-tutorial.html
* **it's fully documented**: see the official docs at https://docs.microsoft.com/en-us/powershell/

How to get PowerShell?
----------------------
* **On Windows 7 and newer** PowerShell is provided by default. However, script execution is **not allowed by default** (execution policy is "restricted"). To enable this, enter as administrator:
   ```
   $ Set-ExecutionPolicy RemoteSigned
   ```
* **On CentOS, Debian, Docker, Fedora, macOS, openSUSE, Red Hat, Ubuntu** visit https://github.com/PowerShell/PowerShell for installation.
* **Want to use Snaps?** Install the PowerShell snap by executing:
   ```
   $ snap install PowerShell
   $ ln -s /snap/bin/pwsh /usr/bin/pwsh
   ```

How to get the PowerShell Scripts?
----------------------------------
* Git users execute: `$ git clone https://github.com/fleschutz/PowerShell`
* otherwise download it from: https://github.com/fleschutz/PowerShell/archive/master.zip

Some Scripts show gibberish characters. How to fix that?
--------------------------------------------------------
The PowerShell scripts support Unicode input & output! Use a modern console supporting UTF-8 such as Windows Terminal.


How to set PowerShell as Default Shell on Linux?
------------------------------------------------
Make sure PowerShell is installed, then execute: `chsh -s /usr/bin/pwsh <username>`. In case you experience an "invalid shell" error, add "/usr/bin/pwsh" to /etc/shells.


How to add the Scripts to the Search Path?
------------------------------------------
Want to use the PowerShell scripts everywhere on the command-line? Then you need to add the Scripts/ subfolder to the search path:

* **On Linux using Bash:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **On Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"


How to use PowerShell in Context Menus?
---------------------------------------
* to enable "right-click > New > Windows PowerShell Script" execute `Add_ps1_to_New_context_menu.reg` in subfolder [Misc/](Misc)
* to disable this execute `Remove_ps1_from_New_context_menu.reg` in subfolder [Misc/](Misc)


How to edit the PowerShell Scripts?
-----------------------------------
* use *PowerShell ISE* (Integrated Scripting Environment) to write, test and debug scripts (available for free on Windows only).
* use *Visual Studio Code* supporting syntax highlighting, on-the-fly problem checking and an integrated PowerShell Console (available for free on Linux, Mac OS and Windows).
* or simply use your *favorite text editor*

How to write good PowerShell Scripts?
-------------------------------------
Good PowerShell scripts are user-friendly and platform-independant. As a guideline follow these rules, please:

1. the filename is named using the `<verb>-<object>.ps1` scheme
2. the encoding is UTF-8-BOM to support and use Unicode characters (including emojis where appropriate)
3. the script has execute file permissions: chmod a+rx <file> (for Linux support)
4. provide a comment-based help with syntax, description, link, author, and license
5. check the requirements (e.g. #Requires -RunAsAdministrator, or #Requires -Version 3)
6. prefer command-line options, else ask the user for help
7. recommended is `Set-StrictMode -Version Latest` to enable additional error checking
8. for readibility use UpperCamelCase for variables and functions, lowerCamelCase for everything else
9. on error call write-error with keyword "ERROR:" (to support log parsers) and exit the error code (mostly 1)
10. on success exit with error code 0 (exit 0)

Your Question is not answered here?
-----------------------------------
Send your question to: markus [at] fleschutz [dot] de
