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
   $ ln -s /snap/bin/powershell /bin/powershell
   ```

How to get the PowerShell Scripts?
----------------------------------
* Git users execute: `$ git clone https://github.com/fleschutz/PowerShell`
* otherwise download it from: https://github.com/fleschutz/PowerShell/archive/master.zip


How to use PowerShell by Default?
---------------------------------
* **On Linux:** make sure PowerShell is installed, then execute: `chsh -s /bin/powershell <username>`
* **On Windows:** no need to, PowerShell is the default shell


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
Each PowerShell script should follow the 10 golden rules:

1. the filename should be named `<verb>-<object>.ps1`
2. the first line reads `#!/bin/powershell` (to support Linux)
3. the script has execute file permissions: chmod a+rx <file> (to support Linux)
4. provide a comment-based help with syntax, description, link, author, and license
5. check the requirements (e.g. #Requires -RunAsAdministrator, or #Requires -Version 3)
6. prefer command-line options, else ask the user
7. recommended is `Set-StrictMode -Version Latest` to enable additional error checking
8. for readibility use UpperCamelCase for variables and functions, lowerCamelCase for everything else
9. on error call write-error with keyword "ERROR:" (to support log parsers) and exit the error code (mostly 1)
10. on success exit with error code 0 (exit 0)

Your Question is not answered here?
-----------------------------------
Send your question to: markus [at] fleschutz [dot] de
