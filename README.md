Collection of Useful PowerShell Scripts
=======================================

This repository contains 50+ useful cross-platform PowerShell scripts - to be used by command-line (CLI), for remote control (RC), by context menu, by voice control, by automation software (e.g. Jenkins), or simply for learning.

List of Scripts
---------------
The following PowerShell scripts can be found in the [Scripts/](Scripts/) subfolder:

* [clone-repos.ps1](Scripts/clone-repos.ps1) - clones well-known Git repositories
* [configure-git.ps1](Scripts/configure-git.ps1) - sets up the Git configuration
* [download.ps1](Scripts/download.ps1) - downloads the file/directory from the given URL
* [empty-dir.ps1](Scripts/empty-dir.ps1) - empties the given directory
* [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) - enables the writing of crash dumps
* [inspect-exe.ps1](Scripts/inspect-exe.ps1) - prints basic information of the given executable file
* [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1) - lists empty subfolders in a directory tree
* [list-unused-files.ps1](Scripts/list-unused-files.ps1) - lists unused files in a directory tree
* [list-cmdlets.ps1](Scripts/list-cmdlets.ps1) - lists the PowerShell cmdlets
* [list-modules.ps1](Scripts/list-modules.ps1) - lists the PowerShell modules
* [list-passwords.ps1](Scripts/list-passwords.ps1) - generates and prints a list of new passwords
* [list-processes.ps1](Scripts/list-processes.ps1) - lists the local computer processes
* [locate-city.ps1](Scripts/locate-city.ps1) - prints the lat/long coordinates of the given city
* [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) - locates the geographic position of the given IP address
* [MD5.ps1](Scripts/MD5.ps1) - prints the MD5 checksum of the given file
* [make-install.ps1](Scripts/make-install.ps1) - installs built executables and libs to the installation directory
* [moon.ps1](Scripts/moon.ps1) - prints the current moon phase
* [open-browser.ps1](Scripts/open-browser.ps1) - starts the default Web browser
* [open-email-client.ps1](Scripts/open-browser.ps1) - starts the default email client
* [poweroff.ps1](Scripts/poweroff.ps1) - halts the local computer (needs administrator rights)
* [new-email.ps1](Scripts/new-email.ps1) - starts the default email client to write a new email
* [news.ps1](Scripts/news.ps1) - prints the latest news
* [reboot.ps1](Scripts/reboot.ps1) - reboots the local computer (needs administrator rights)
* [scan-ports.ps1](Scripts/scan-ports.ps1) - scans the network for open/closed ports
* [send-email.ps1](Scripts/send-email.ps1) - sends an email message
* [send-tcp.ps1](Scripts/send-udp.ps1) - sends a TCP message to the given IP address and port
* [send-udp.ps1](Scripts/send-udp.ps1) - sends a UDP datagram message to the given IP address and port
* [SHA1.ps1](Scripts/SHA1.ps1) - prints the SHA1 checksum of the given file
* [SHA256.ps1](Scripts/SHA256.ps1) - prints the SHA256 checksum of the given file
* [simulate-presence.ps1](Scripts/simulate-presence.ps1) - simulates the human presence against burglars
* [simulate-typewriter.ps1](Scripts/simulate-typewriter.ps1) - prints a message with the typewriter effect
* [speak-file.ps1](Scripts/speak-file.ps1) - speaks the content of the given text file by text-to-speech (TTS)
* [speak-text.ps1](Scripts/speak-text.ps1) - speaks the given text by text-to-speech (TTS)
* [switch-shelly1.ps1](Scripts/switch-shelly1.ps1) - switches a Shelly1 device in the local network
* [take-screenshot.ps1](Scripts/take-screenshot.ps1) - takes a single screenshot
* [take-screenshots.ps1](Scripts/take-screenshots.ps1) - takes multiple screenshots
* [test.ps1](Scripts/test.ps1) - simple test script
* [train-dns-cache.ps1](Scripts/train-dns-cache.ps1) - trains the DNS cache with frequently used domain names
* [translate-file.ps1](Scripts/translate-file.ps1) - translates the given file from source to target language
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

* **it's powerful**: fully control your computer
* **it's cross-platform**: available for Linux, Mac OS and Windows
* **it's open-source**: see the Github repository at https://github.com/PowerShell/PowerShell 
* **it's easy to learn**: see the tutorial at https://www.guru99.com/powershell-tutorial.html
* **it's fully documented**: see the official docs at https://docs.microsoft.com/en-us/powershell/

How to get PowerShell?
----------------------
* **Windows 7 and newer** do provide PowerShell by default. It's recommended to install **Windows Terminal** (see the Microsoft Store at https://www.aka.ms/terminal) for a comfortable command-line usage. Per default, Windows does not allow script execution (execution policy "restricted"). To enable this, enter as administrator:
   ```
   $ Set-ExecutionPolicy RemoteSigned
   ```
* **On CentOS, Debian, Docker, Fedora, macOS, openSUSE, Red Hat, Ubuntu** visit https://github.com/PowerShell/PowerShell for installation.

Afterward, install this collection by clicking on the green "Code" button or execute:
```
$ git clone https://github.com/fleschutz/PowerShell
```

Configure PowerShell as Default Shell
-------------------------------------
* **Linux:** make sure PowerShell is installed, then execute: `chsh -s /snap/bin/powershell <username>`
* **Windows:** no need to, PowerShell is the default shell


Adding the Scripts to the Search Path
-------------------------------------
Want to use the PowerShell scripts everywhere on the command-line? Then you need to add the Scripts/ subfolder to the search path:

* **Bash or sh:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"


Using PowerShell in Context Menus
----------------------------------
* to enable "right-click > New > Windows PowerShell Script" execute `Add_ps1_to_New_context_menu.reg` in subfolder [Context_Menus/](Context_Menus)
* to disable this execute `Remove_ps1_from_New_context_menu.reg` in subfolder [Context_Menus/](Context_Menus)

Script Conventions
------------------
Each PowerShell script should follow the 7 golden rules:

* **Rule #1:** the filename should be named `<verb>-<object>.ps1`
* **Rule #2:** the first line reads: #!/snap/bin/powershell (to support PowerShell on Linux)
* **Rule #3:** the script has execute file permissions (chmod a+rx <file>) to support PowerShell on Linux
* **Rule #4:** provide a metadata header with syntax, description, author, source, and license
* **Rule #5:** prefer command-line options, else ask the user
* **Rule #6:** the encoding of the script is in UTF-8 with BOM to support Unicode characters
* **Rule #7:** exits 0 for success, else print an error message and exit with the error code (mostly 1)

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
