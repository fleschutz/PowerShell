Collection of Useful PowerShell Scripts (CUPS)
==============================================

This repository contains 41 useful cross-platform PowerShell scripts - to be used on the command-line (CLI), by context menu, by voice control, or by automation software (e.g. Jenkins).

List of Scripts
---------------
The following PowerShell scripts can be found in the [Scripts/](Scripts/) subfolder:

* [clone-repos.ps1](Scripts/clone-repos.ps1) - clones well-known Git repositories
* [configure-git.ps1](Scripts/configure-git.ps1) - sets up the Git configuration
* [download.ps1](Scripts/download.ps1) - downloads the file/directory from the given URL
* [empty-dir.ps1](Scripts/empty-dir.ps1) - empties the given directory
* [inspect-exe.ps1](Scripts/inspect-exe.ps1) - prints basic information of the given executable file
* [latlong.ps1](Scripts/latlong.ps1) - prints the lat/long coordinates of the given city
* [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1) - lists empty subfolders in a directory tree
* [list-unused-files.ps1](Scripts/list-unused-files.ps1) - lists unused files in a directory tree
* [list-cmdlets.ps1](Scripts/list-cmdlets.ps1) - lists the PowerShell cmdlets
* [list-modules.ps1](Scripts/list-modules.ps1) - lists the PowerShell modules
* [list-processes.ps1](Scripts/list-processes.ps1) - lists the local computer processes
* [MD5.ps1](Scripts/MD5.ps1) - prints the MD5 checksum of the given file
* [make-install.ps1](Scripts/make-install.ps1) - installs built executables and libs to the installation directory
* [moon.ps1](Scripts/moon.ps1) - prints the current moon phase
* [password.ps1](Scripts/password.ps1) - generates and prints a single new password
* [passwords.ps1](Scripts/passwords.ps1) - generates and prints a list of new passwords
* [poweroff.ps1](Scripts/poweroff.ps1) - halts the local computer, administrator rights might be needed
* [news.ps1](Scripts/news.ps1) - prints the latest news
* [reboot.ps1](Scripts/reboot.ps1) - reboots the local computer, administrator rights might be needed
* [scan-ports.ps1](Scripts/scan-ports.ps1) - scans the network for open/closed ports
* [send-email.ps1](Scripts/send-email.ps1) - sends an email message
* [send-udp.ps1](Scripts/send-udp.ps1) - sends a UDP datagram message to the given IP address and port
* [SHA1.ps1](Scripts/SHA1.ps1) - prints the SHA1 checksum of the given file
* [SHA256.ps1](Scripts/SHA256.ps1) - prints the SHA256 checksum of the given file
* [simulate-presence.ps1](Scripts/simulate-presence.ps1) - simulates the human presence against burglars
* [speak-file.ps1](Scripts/speak-file.ps1) - speaks the content of the given text file by text-to-speech (TTS)
* [speak-text.ps1](Scripts/speak-text.ps1) - speaks the given text by text-to-speech (TTS)
* [switch-shelly1.ps1](Scripts/switch-shelly1.ps1) - switches a Shelly1 device in the local network
* [take-screenshot.ps1](Scripts/take-screenshot.ps1) - takes a single screenshot
* [take-screenshots.ps1](Scripts/take-screenshots.ps1) - takes multiple screenshots
* [test.ps1](Scripts/test.ps1) - simple test script
* [train-dns-cache.ps1](Scripts/train-dns-cache.ps1) - trains the DNS cache with frequently used domain names
* [translate-text.ps1](Scripts/translate-text.ps1) - translates the given text into other languages
* [txt2wav.ps1](Scripts/txt2wav.ps1) - converts text into a audio .WAV file
* [validate-xml.ps1](Scripts/validate-xml.ps1) - validates the given XML file
* [weather.ps1](Scripts/weather.ps1) - prints the current weather forecast
* [weather-alert.ps1](Scripts/weather-alert.ps1) - checks the current weather for critical values
* [weather-report.ps1](Scripts/weather-report.ps1) - prints the local weather report
* [weather-worldwide.ps1](Scripts/weather-worldwide.ps1) - prints the current weather of cities world-wide
* [wakeup.ps1](Scripts/wakeup.ps1) - sends a magic packet to the given computer, waking him up
* [zip-dir.ps1](Scripts/zip-dir.ps1) - creates a zip archive of the given folder


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

Configure PowerShell as Default Shell
-------------------------------------
* **Linux:** make sure PowerShell is installed, then execute: `chsh -s /snap/bin/powershell <username>`
* **Windows:** no need to, PowerShell is the default shell


Adding Subfolder Scripts/ to the Search Path for Command-line Usage
-------------------------------------------------------------------
* **Bash or sh:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"


Using PowerShell in Windows Context Menus
------------------------------------------
* to enable "right-click > New > Windows PowerShell Script" just execute Context_Menus/add_ps1_to_New_context_menu.reg
* to disable it just execute Context_Menus/remove_ps1_from_New_context_menu.reg

Script Conventions
------------------
Each PowerShell script should follow the 7 golden rules:

* **Rule 1:** the filename should be named `<verb>-<object>.ps1`
* **Rule 2:** to support PowerShell on Linux the first line reads: #!/snap/bin/powershell
* **Rule 3:** to support PowerShell on Linux the script has execute file permissions (chmod a+rx <file>)
* **Rule 4:** add a metadata header containing the syntax, description, author, source, and license
* **Rule 5:** prefer command-line options, but may ask the user in case no option is given
* **Rule 6:** the encoding of the script is in UTF-8 with BOM to support Unicode characters
* **Rule 7:** exit 0 for success, else print an error message and exit with the error code (mostly 1)

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
