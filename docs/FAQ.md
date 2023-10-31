![](powershell_black_icon_64x64.png) PowerShell FAQ
===================================================

<details><summary>What is PowerShell?</summary>
 
**PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language.**
 
</details>

<details><summary>Why use PowerShell?</summary>
 
✔️ **It's powerful** - fully control your computer

✔️ **It's easy to learn** - see the tutorial at: https://www.guru99.com/powershell-tutorial.html

✔️ **It's cross-platform** - available for Linux, Mac OS and Windows

✔️ **It's open-source and free** - see the Github repository at: https://github.com/PowerShell/PowerShell

✔️ **It's fully documented** - see the official documentation at: https://docs.microsoft.com/en-us/powershell
</details>

<details><summary>How to install PowerShell on Linux?</summary>
 
1. **On Linux with Snap support just execute:**
```
 $ snap install PowerShell
 $ ln -s /snap/bin/pwsh /usr/bin/pwsh
```
2. **Otherwise, please visit:** https://github.com/PowerShell/PowerShell **and scroll down to: 'Get PowerShell'.**
</details>

<details><summary>How to install PowerShell on MacOS?</summary>

**Please visit:** https://github.com/PowerShell/PowerShell **and scroll down to: 'Get PowerShell'.**
</details>

<details><summary>How to install PowerShell on Windows?</summary>

**Good news:** it's preinstalled, **but** the script execution policy is *restricted* (forbidden) by default! To change this: open the *Windows PowerShell (Admin)* console and enter:
```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
**NOTE:** the group policy object (GPO) settings of your organization might disallow changes. In that case contact your system administrator for help.
</details>

<details><summary>How to get the Mega collection of PowerShell scripts?</summary>
 
1. **When using Git, execute in a terminal window:** `> git clone https://github.com/fleschutz/PowerShell`
2. **Otherwise, download and unzip it from:** https://github.com/fleschutz/PowerShell/archive/master.zip
</details>

<details><summary>How to execute PowerShell scripts on Windows?</summary>

1. **In the Windows desktop:** right-click the script and select: *Execute with PowerShell*
2. **On the command-line:** launch a terminal application (e.g. *Windows Terminal*), then type: `./<SCRIPT>.ps1`.
3. **By remote login:** use *SSH* to login to the Windows machine, then type: `cd <PATH>`, then: `./<SCRIPT>.ps1`.
4. **By context menu:** see below.
5. **By voice control:** see repo [talk2windows](https://github.com/fleschutz/talk2windows) for more information.
6. **By automation software:** see [Jenkins.io](https://www.jenkins.io) or [AutoHotKey.com](https://www.autohotkey.com/) for more information.
7. **Automatically on login:** see below.
 </details>
 
<details><summary>How to execute PowerShell scripts in Windows context menus?</summary>
   
* To enable "right-click > New > Windows PowerShell Script" execute `Add_ps1_to_New_context_menu.reg` in subfolder [Data/](../Data)
* To disable this execute `Remove_ps1_from_New_context_menu.reg` in subfolder [Data/](../Data)
</details>

<details><summary>How to execute PowerShell scripts automatically on login in Windows?</summary>

1. **Open the *File Explorer* with your Autostart folder** (usually at: `C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`).
2. **Copy the script (or a link to it) into this folder.**
</details>
 
<details><summary>How to execute PowerShell scripts in Jenkins?</summary>
 
1. **Install the Jenkins plugin:** `PowerShell plugin` (it uses PowerShell.exe on Windows and pwsh on Linux).
2. **Add or reference your PowerShell scripts in the Jenkins jobs or in your Jenkinsfiles.**
</details>

<details><summary>How to learn PowerShell?</summary>

* **Please find tutorials at:** https://www.guru99.com/powershell-tutorial.html
* **See a cheat sheet at:** [PowerShell/Docs/cheat-sheet.md](cheat-sheet.md)
* **The official PowerShell documentation can be found here:** https://docs.microsoft.com/en-us/powershell/
</details>

<details><summary>What about security?</summary>

1. **Execute scripts only that you trust (and/or where you have checked the code before)!**
2. **Prefer SSH Remoting instead of PowerShell Remoting**
3. **More recommendations by NSA and cyber security centers in the U.S. (CISA), New Zealand (NZ NCSC), and the U.K. (NCSC-UK) can be found here:** https://media.defense.gov/2022/Jun/22/2003021689/-1/-1/1/CSI_KEEPING_POWERSHELL_SECURITY_MEASURES_TO_USE_AND_EMBRACE_20220622.PDF
 </details>

<details><summary>Why do some scripts show gibberish characters?</summary>
  
**Your current terminal application doesn't support Unicode characters used by those PowerShell scripts.**

**Use a modern one such as *Windows Terminal*, please.**
</details>

<details><summary>How to configure PowerShell as my default shell on Linux?</summary>
  
**Make sure PowerShell is installed, then execute: `chsh -s /usr/bin/pwsh USERNAME`. In case you experience an "invalid shell" error, add "/usr/bin/pwsh" to /etc/shells.**
</details>

<details><summary>How to install a custom PowerShell profile?</summary>
   
**Execute: `./set-profile.ps1` in the *Scripts* subfolder, this will install **my-profile.ps1** as your PowerShell profile. It's a nice looking base profile, but can easily be changed to your needs.**
</details>

 <details><summary>How to add the scripts to the search path?</summary>

Want to use the PowerShell scripts everywhere on the command-line? Then you need to add the Scripts/ subfolder to the search path:

* **On Linux using Bash:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **On Windows:** open Settings > System > About > Advanced system settings > Environment Variables, edit the user's variable "Path", and add the full path to the Scripts/ directory.
   </details>

<details><summary>Which editor to use for PowerShell scripts?</summary>

* **Visual Studio Code** - it supports syntax highlighting, on-the-fly problem checking and an integrated PowerShell Console (available for free on Linux, Mac OS and Windows, now recommended by Microsoft).
* **PowerShell ISE** (Integrated Scripting Environment) - the former official PowerShell development environment included with Microsoft Windows.
* **PowerShell Studio** - a powerful PowerShell IDE with module, help, and user interface development tools, high DPI support and regular updates.
* **PowerShell Plus** - an all in one IDE.
* **Atom package** - an add-on with PowerShell language support for Atom.
* **SublimeText package** - an add-on with PowerShell language support for Sublime Text.
* or simply your **favorite text editor** as an alternative.
</details>

<details><summary>How to write good PowerShell scripts?</summary>
 
**Good PowerShell scripts are both user-friendly and platform-independent. As a starting point I recommend the following:**

* Use the `<verb>-<noun>.ps1` scheme for filenames (e.g. *new-symlink.ps1*). Official approved verbs can be found here: [https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands)
* Use **UTF-8 BOM** encoding to support Unicode characters in the script.
* Add a **comment-based help** at the beginning with: `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`, `.LINK`, and `.NOTES`.
* Check the **requirements** for the script, e.g. `#Requires -RunAsAdministrator`, or `#Requires -Version 3`
* Prefer **command-line options**, else ask the user for help
* Recommended is **Set-StrictMode -Version Latest** to enable additional error checking.
* For readibility use **lowerCamelCase** to name variables, functions, etc.
* Set execute file permissions for Linux: **chmod a+rx <filename>**
* On success exit with error code 0 (**exit 0**), otherwise print the error with keyword **ERROR:** (to support log parsers) and exit the error code (mostly 1)
 </details>

<details><summary>Where's the Star History of this repository?</summary>
    
[![Star History Chart](https://api.star-history.com/svg?repos=fleschutz/PowerShell&type=Date)](https://star-history.com/#fleschutz/PowerShell&Date)
</details>

<details><summary>How to contribute or how to report a bug?</summary>

**If you find something bad (like a bug, error, or any issue), please report it here by opening an Issue.**

**Or even better: Fork the repository, add or fix the script and submit a pull request, so others can participate too.**
</details>

<details><summary>How to donate to this project?</summary>

**Thanks a lot! Just follow this link:** [https://www.paypal.com/paypalme/Fleschutz](https://www.paypal.com/paypalme/Fleschutz)
</details>

<details><summary>What if my question is not answered here?</summary>
 
**Just send your question by e-mail to:** `markus.fleschutz [at] gmail.com`
</details>
