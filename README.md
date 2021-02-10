Collection of PowerShell Scripts
================================

**This repository contains 120+ useful and cross-platform PowerShell scripts in the [Scripts/](Scripts/) subfolder - to be used by command-line interface (CLI), for remote control (RC), by context menu, by voice control, by automation software like Jenkins, automatically as daily tasks, or simply to learn PowerShell.**

Table of Contents
-----------------
* [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) - adds firewall rules for the given executables (requires admin rights)
* [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1) - checks the given IPv4 address for validity
* [check-mac-address.ps1](Scripts/check-mac-address.ps1) - checks the given MAC address for validity
* [check-symlinks.ps1](Scripts/check-symlinks.ps1) - checks every symlink in the given directory tree
* [check-xml-file.ps1](Scripts/check-xml-file.ps1) - checks the given XML file for validity
* [clone-repos.ps1](Scripts/clone-repos.ps1) - clones well-known Git repositories
* [close-calculator.ps1](Scripts/close-calculator.ps1) - closes the calculator program gracefully
* [close-chrome.ps1](Scripts/close-chrome.ps1) - closes Google Chrome gracefully
* [close-edge.ps1](Scripts/close-edge.ps1) - closes Microsoft Edge gracefully
* [close-file-explorer.ps1](Scripts/close-file-explorer.ps1) - closes Microsoft File Explorer gracefully
* [close-program.ps1](Scripts/close-program.ps1) - closes the given program gracefully
* [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) - closes Mozilla Thunderbird gracefully
* [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) - closes Windows Terminal gracefully
* [configure-git.ps1](Scripts/configure-git.ps1) - sets up the Git user configuration
* [csv-to-text.ps1](Scripts/csv-to-text.ps1) - converts the given CSV file into a text list
* [daily-tasks.sh](Scripts/daily-tasks.sh) - execute PowerShell scripts automatically as daily tasks (Linux only)
* [decrypt-file.ps1](Scripts/decrypt-file.ps1) - encrypts the given file
* [display-time.ps1](Scripts/display-time.ps1) - displays the current time for 10 seconds by default
* [download.ps1](Scripts/download.ps1) - downloads the file/directory from the given URL
* [empty-dir.ps1](Scripts/empty-dir.ps1) - empties the given directory
* [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) - enables the writing of crash dumps
* [encrypt-file.ps1](Scripts/encrypt-file.ps1) - encrypts the given file
* [generate-qrcode.ps1](Scripts/generate-qrcode.ps1) - generates a QR code
* [hibernate.ps1](Scripts/hibernate.ps1) - enables hibernate mode for the local computer (requires admin rights)
* [inspect-exe.ps1](Scripts/inspect-exe.ps1) - prints basic information of the given executable file
* [list-anagrams.ps1](Scripts/list-anagrams.ps1) - lists all anagrams of the given word
* [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) - lists the automatic variables of PowerShell 
* [list-clipboard.ps1](Scripts/list-clipboard.ps1) - lists the contents of the clipboard
* [list-current-timezone.ps1](Scripts/list-current-timezone.ps1) - lists the current time zone details
* [list-environment-variables.ps1](Scripts/list-environment-variables.ps1) - lists all environment variables
* [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1) - lists empty subfolders within the given directory tree
* [list-installed-software.ps1](Scripts/list-installed-software.ps1) - lists the installed software
* [list-files.ps1](Scripts/list-files.ps1) - lists all files in the given folder and also in every subfolder
* [list-formatted.ps1](Scripts/list-formatted.ps1) - lists the current working directory formatted in columns
* [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1) - lists the FRITZ!Box calls
* [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1) - lists FRITZ!Box's known devices 
* [list-logbook.ps1](Scripts/list-logbook.ps1) - lists the content of the logbook 
* [list-unused-files.ps1](Scripts/list-unused-files.ps1) - lists unused files in a directory tree
* [list-cmdlets.ps1](Scripts/list-cmdlets.ps1) - lists the PowerShell cmdlets
* [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) - lists earthquakes with magnitude >= 6.0 for the last 30 days
* [list-modules.ps1](Scripts/list-modules.ps1) - lists the PowerShell modules
* [list-news.ps1](Scripts/list-news.ps1) - lists the latest news
* [list-os-releases.ps1](Scripts/list-os-releases.ps1) - lists OS releases and download URL
* [list-printers.ps1](Scripts/list-printers.ps1) - lists all printer known to the computer
* [list-processes.ps1](Scripts/list-processes.ps1) - lists the local computer processes
* [list-random-passwords.ps1](Scripts/list-random-passwords.ps1) - prints a list of random passwords
* [list-random-pins.ps1](Scripts/list-random-pins.ps1) - prints a list of random PIN's
* [list-scripts.ps1](Scripts/list-scripts.ps1) - lists the PowerShell scripts in this repository
* [list-timezones.ps1](Scripts/list-timezones.ps1) - lists all time zones available 
* [list-user-groups.ps1](Scripts/list-user-groups.ps1) - lists the user groups on the local computer
* [locate-city.ps1](Scripts/locate-city.ps1) - prints the geographic location of the given city
* [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) - prints the geographic location of the given IP address
* [locate-zip-code.ps1](Scripts/locate-zip-code.ps1) - prints the geographic location of the given zip-code
* [MD5.ps1](Scripts/MD5.ps1) - prints the MD5 checksum of the given file
* [make-install.ps1](Scripts/make-install.ps1) - installs built executables and libs to the installation directory
* [moon.ps1](Scripts/moon.ps1) - prints the current moon phase
* [mute-audio.ps1](Scripts/mute-audio.ps1) - mutes audio
* [open-browser.ps1](Scripts/open-browser.ps1) - starts the default Web browser
* [open-calculator.ps1](Scripts/open-calculator.ps1) - starts the calculator program
* [open-email-client.ps1](Scripts/open-browser.ps1) - starts the default email client
* [play-beep.ps1](Scripts/play-beep.ps1) - plays a beep sound
* [poweroff.ps1](Scripts/poweroff.ps1) - halts the local computer (requires admin rights)
* [query-smart-data.ps1](Scripts/query-smart-data.ps1) - queries the S.M.A.R.T. data of your HDD/SSD's 
* [new-email.ps1](Scripts/new-email.ps1) - starts the default email client to write a new email
* [next-joke.ps1](Scripts/next-joke.ps1) - gets the next random Juck Norris joke
* [reboot.ps1](Scripts/reboot.ps1) - reboots the local computer (requires admin rights)
* [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1) - reboots the FRITZ!box device
* [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) - removes empty subfolders within the given directory tree
* [search-files.ps1](Scripts/search-files.ps1) - searches the given pattern in the given files
* [scan-ports.ps1](Scripts/scan-ports.ps1) - scans the network for open/closed ports
* [send-email.ps1](Scripts/send-email.ps1) - sends an email message
* [send-tcp.ps1](Scripts/send-udp.ps1) - sends a TCP message to the given IP address and port
* [send-udp.ps1](Scripts/send-udp.ps1) - sends a UDP datagram message to the given IP address and port
* [set-timer.ps1](Scripts/set-timer.ps1) - sets a timer for a countdown
* [set-wallpaper.ps1](Scripts/set-wallpaper.ps1) - sets the given image as wallpaper
* [SHA1.ps1](Scripts/SHA1.ps1) - prints the SHA1 checksum of the given file
* [SHA256.ps1](Scripts/SHA256.ps1) - prints the SHA256 checksum of the given file
* [simulate-matrix.ps1](Scripts/simulate-matrix.ps1) - simulates the Matrix (fun)
* [simulate-presence.ps1](Scripts/simulate-presence.ps1) - simulates the human presence against burglars
* [speak-date.ps1](Scripts/speak-date.ps1) - speaks the current date by text-to-speech (TTS)
* [speak-english.ps1](Scripts/speak-english.ps1) - speaks the given text with an English text-to-speech (TTS) voice
* [speak-epub.ps1](Scripts/speak-epub.ps1) - speaks the content of the given Epub file by text-to-speech (TTS)
* [speak-file.ps1](Scripts/speak-file.ps1) - speaks the content of the given text file by text-to-speech (TTS)
* [speak-german.ps1](Scripts/speak-german.ps1) - speaks the given text with a German text-to-speech (TTS) voice
* [speak-joke.ps1](Scripts/speak-joke.ps1) - speaks the next joke by text-to-speech (TTS)
* [speak-test.ps1](Scripts/speak-test.ps1) - performs a speak test by text-to-speech (TTS)
* [speak-text.ps1](Scripts/speak-text.ps1) - speaks the given text by text-to-speech (TTS)
* [speak-time.ps1](Scripts/speak-time.ps1) - speaks the current time by text-to-speech (TTS)
* [switch-shelly1.ps1](Scripts/switch-shelly1.ps1) - switches a Shelly1 device in the local network
* [take-screenshot.ps1](Scripts/take-screenshot.ps1) - takes a single screenshot
* [take-screenshots.ps1](Scripts/take-screenshots.ps1) - takes multiple screenshots
* [train-dns-cache.ps1](Scripts/train-dns-cache.ps1) - trains the DNS cache with frequently used domain names
* [translate-file.ps1](Scripts/translate-file.ps1) - translates the given file from source to target language
* [translate-text.ps1](Scripts/translate-text.ps1) - translates the given text into other languages
* [turn-volume-up.ps1](Scripts/turn-volume-up.ps1) - turns the audio volume up (+10% by default)
* [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) - turns the audio volume down (-10% by default)
* [txt2wav.ps1](Scripts/txt2wav.ps1) - converts text into a audio .WAV file
* [unmute-audio.ps1](Scripts/unmute-audio.ps1) - unmutes audio
* [update-repos.ps1](Scripts/update-repos.ps1) - updates all Git repositories under the current directory
* [visualize-dir-tree.ps1](Scripts/visualize-dir-tree.ps1) - visualizes the given/current directory tree
* [voice-control.ps1](Scripts/voice-control.ps1) - executes the PowerShell scripts by voice
* [weather.ps1](Scripts/weather.ps1) - prints the current weather forecast
* [weather-alert.ps1](Scripts/weather-alert.ps1) - checks the current weather for critical values
* [weather-report.ps1](Scripts/weather-report.ps1) - prints the local weather report
* [weather-worldwide.ps1](Scripts/weather-worldwide.ps1) - prints the current weather of cities worldwide
* [wakeup.ps1](Scripts/wakeup.ps1) - sends a magic packet to the given computer, waking him up
* [write-animated.ps1](Scripts/write-animated.ps1) - writes animated text
* [write-big.ps1](Scripts/write-big.ps1) - writes the given text in big letters
* [write-blue.ps1](Scripts/write-blue.ps1) - writes the given text in a blue foreground color
* [write-braille.ps1](Scripts/write-braille.ps1) - writes the given text in Braille
* [write-green.ps1](Scripts/write-green.ps1) - writes the given text in a green foreground color
* [write-logbook.ps1](Scripts/write-logbook.ps1) - writes the given text to the logbook
* [write-marquee.ps1](Scripts/write-marquee.ps1) - writes the given text as marquee
* [write-morse-code.ps1](Scripts/write-morse-code.ps1) - writes the given text in Morse code
* [write-motd.ps1](Scripts/write-motd.ps1) - writes the message of the day (MOTD)
* [write-red.ps1](Scripts/write-red.ps1) - writes the given text in a red foreground color
* [write-rot13.ps1](Scripts/write-rot13.ps1) - encodes or decodes the given text with ROT13
* [write-typewriter.ps1](Scripts/write-typewriter.ps1) - writes the given text with the typewriter effect
* [write-uppercase.ps1](Scripts/write-uppercase.ps1) - writes the given text in uppercase letters
* [write-vertical.ps1](Scripts/write-vertical.ps1) - writes the given text in vertical direction
* [zip-dir.ps1](Scripts/zip-dir.ps1) - creates a zip archive of the given directory


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
* **Linux:** make sure PowerShell is installed, then execute: `chsh -s /bin/powershell <username>`
* **Windows:** no need to, PowerShell is the default shell


Adding the Scripts to the Search Path
-------------------------------------
Want to use the PowerShell scripts everywhere on the command-line? Then you need to add the Scripts/ subfolder to the search path:

* **Bash or sh:** edit .profile in your home directory and add the line: PATH="$PATH:/path/to/PowerShell/Scripts"
* **Windows:** open the environment variables dialogue and add the full path to Scripts/ to the system environment variable "Path"


Using PowerShell in Context Menus
----------------------------------
* to enable "right-click > New > Windows PowerShell Script" execute `Add_ps1_to_New_context_menu.reg` in subfolder [Misc/](Misc)
* to disable this execute `Remove_ps1_from_New_context_menu.reg` in subfolder [Misc/](Misc)

Script Conventions
------------------
Each PowerShell script should follow the 9 golden rules:

1. the filename should be named `<verb>-<object>.ps1`
2. the first line reads `#!/bin/powershell` to support PowerShell on Linux
3. the script has execute file permissions (chmod a+rx <file>) to support PowerShell on Linux
4. provide a comment-based help with syntax, description, link, author, and license
5. check the requirements (e.g. #Requires -RunAsAdministrator, or #Requires -Version 3)
6. prefer command-line options, else ask the user
7. use `Set-StrictMode -Version Latest` to enable additional error checking
8. for readibility use UpperCamelCase for variables and functions, lowerCamelCase for everything else
9. exit 0 for success, else print an error message and exit with the error code (mostly 1)

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
