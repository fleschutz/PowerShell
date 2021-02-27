Collection of PowerShell Scripts
================================

**This repository contains 140+ useful and cross-platform PowerShell scripts in the [Scripts/ folder](Scripts/) - to be used by command-line interface (CLI), for remote control (RC), by context menu, by voice control, by automation software like Jenkins, automatically as daily tasks, or simply to learn PowerShell. See the [FAQ page](Misc/FAQ.md) if you need help or have any questions.**

Scripts for Audio & Voice 🔊
---------------------------
* [mute-audio.ps1](Scripts/mute-audio.ps1) - mutes audio
* [play-beep.ps1](Scripts/play-beep.ps1) - plays a beep sound
* [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) - plays the Mission Impossible theme
* [play-m3u.ps1](Scripts/play-m3u.ps1) - plays the given playlist (M3U file format)
* [play-mp3.ps1](Scripts/play-mp3.ps1) - plays the given sound file (MP3 file format)
* [play-super-mario.ps1](Scripts/play-super-mario.ps1) - plays the Super Mario Intro
* [play-the-imperial-march.ps1](Scripts/play-the-imperial-march.ps1) - plays the Imperial March (Star Wars)
* [speak-date.ps1](Scripts/speak-date.ps1) - speaks the current date by text-to-speech (TTS)
* [speak-english.ps1](Scripts/speak-english.ps1) - speaks the given text with an English text-to-speech (TTS) voice
* [speak-epub.ps1](Scripts/speak-epub.ps1) - speaks the content of the given Epub file by text-to-speech (TTS)
* [speak-file.ps1](Scripts/speak-file.ps1) - speaks the content of the given text file by text-to-speech (TTS)
* [speak-german.ps1](Scripts/speak-german.ps1) - speaks the given text with a German text-to-speech (TTS) voice
* [speak-joke.ps1](Scripts/speak-joke.ps1) - speaks the next joke by text-to-speech (TTS)
* [speak-test.ps1](Scripts/speak-test.ps1) - performs a speak test by text-to-speech (TTS)
* [speak-text.ps1](Scripts/speak-text.ps1) - speaks the given text by text-to-speech (TTS)
* [speak-time.ps1](Scripts/speak-time.ps1) - speaks the current time by text-to-speech (TTS)
* [txt2wav.ps1](Scripts/txt2wav.ps1) - converts text into a audio .WAV file
* [turn-volume-up.ps1](Scripts/turn-volume-up.ps1) - turns the audio volume up (+10% by default)
* [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) - turns the audio volume down (-10% by default)
* [unmute-audio.ps1](Scripts/unmute-audio.ps1) - unmutes audio
* [voice-control.ps1](Scripts/voice-control.ps1) - executes the PowerShell scripts by voice

Scripts for Computer Management ⚙️
---------------------------------
* [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) - adds firewall rules for the given executables (requires admin rights)
* [check-drive-space.ps1](Scripts/check-drive-space.ps1) - checks the given drive for free space left
* [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) - checks the validity of the Windows system files 
* [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) - enables the writing of crash dumps
* [hibernate.ps1](Scripts/hibernate.ps1) - enables hibernate mode for the local computer (requires admin rights)
* [list-network-shares.ps1](Scripts/list-network-shares.ps1) - lists the network shares of the local computer
* [list-current-timezone.ps1](Scripts/list-current-timezone.ps1) - lists the current time zone details
* [list-installed-apps.ps1](Scripts/list-installed-apps.ps1) - lists the installed Windows Store apps
* [list-installed-software.ps1](Scripts/list-installed-software.ps1) - lists the installed software (except Windows Store apps)
* [list-printers.ps1](Scripts/list-printers.ps1) - lists all printer known to the computer
* [list-processes.ps1](Scripts/list-processes.ps1) - lists the local computer processes
* [list-timezones.ps1](Scripts/list-timezones.ps1) - lists all time zones available 
* [list-user-groups.ps1](Scripts/list-user-groups.ps1) - lists the user groups on the local computer
* [poweroff.ps1](Scripts/poweroff.ps1) - halts the local computer (requires admin rights)
* [query-smart-data.ps1](Scripts/query-smart-data.ps1) - queries the S.M.A.R.T. data of your HDD/SSD's 
* [reboot.ps1](Scripts/reboot.ps1) - reboots the local computer (requires admin rights)
* [wakeup.ps1](Scripts/wakeup.ps1) - sends a magic packet to the given computer, waking him up

Scripts for the Desktop 💻
-------------------------
* [close-calculator.ps1](Scripts/close-calculator.ps1) - closes the calculator program gracefully
* [close-chrome.ps1](Scripts/close-chrome.ps1) - closes Google Chrome gracefully
* [close-cortana.ps1](Scripts/close-cortana.ps1) - closes Cortana gracefully
* [close-edge.ps1](Scripts/close-edge.ps1) - closes Microsoft Edge gracefully
* [close-file-explorer.ps1](Scripts/close-file-explorer.ps1) - closes Microsoft File Explorer gracefully
* [close-program.ps1](Scripts/close-program.ps1) - closes the given program gracefully
* [close-system-settings.ps1](Scripts/close-system-settings.ps1) - closes the System Settings gracefully
* [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) - closes Mozilla Thunderbird gracefully
* [close-vlc.ps1](Scripts/close-vlc.ps1) - closes the VLC media player gracefully
* [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) - closes Windows Terminal gracefully
* [list-clipboard.ps1](Scripts/list-clipboard.ps1) - lists the contents of the clipboard
* [new-email.ps1](Scripts/new-email.ps1) - starts the default email client to write a new email
* [open-browser.ps1](Scripts/open-browser.ps1) - starts the default Web browser
* [open-calculator.ps1](Scripts/open-calculator.ps1) - starts the calculator program
* [open-email-client.ps1](Scripts/open-browser.ps1) - starts the default email client
* [set-wallpaper.ps1](Scripts/set-wallpaper.ps1) - sets the given image as wallpaper
* [take-screenshot.ps1](Scripts/take-screenshot.ps1) - takes a single screenshot
* [take-screenshots.ps1](Scripts/take-screenshots.ps1) - takes multiple screenshots (every minute by default)

Scripts for Files & Folders 📁 
-----------------------------
* [check-symlinks.ps1](Scripts/check-symlinks.ps1) - checks every symlink in the given directory tree
* [check-xml-file.ps1](Scripts/check-xml-file.ps1) - checks the given XML file for validity
* [create-symlink.ps1](Scripts/create-symlink.ps1) - creates a symbolic link
* [decrypt-file.ps1](Scripts/decrypt-file.ps1) - encrypts the given file
* [encrypt-file.ps1](Scripts/encrypt-file.ps1) - encrypts the given file
* [go-downloads.ps1](Scripts/go-downloads.ps1) - go to the user's downloads folder
* [go-home.ps1](Scripts/go-home.ps1) - go to the user's home folder
* [go-music.ps1](Scripts/go-music.ps1) - go to the user's music folder
* [go-scripts.ps1](Scripts/go-scripts.ps1) - go to the PowerShell Scripts folder
* [inspect-exe.ps1](Scripts/inspect-exe.ps1) - prints basic information of the given executable file
* [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1) - lists empty subfolders within the given directory tree
* [list-empty-files.ps1](Scripts/list-empty-files.ps1) - lists empty files within the given directory tree
* [list-files.ps1](Scripts/list-files.ps1) - lists all files in the given folder and also in every subfolder
* [list-formatted.ps1](Scripts/list-formatted.ps1) - lists the current working directory formatted in columns
* [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) - lists hidden files within the given directory tree
* [list-unused-files.ps1](Scripts/list-unused-files.ps1) - lists unused files in a directory tree
* [make-install.ps1](Scripts/make-install.ps1) - installs built executables and libs to the installation directory
* [MD5.ps1](Scripts/MD5.ps1) - prints the MD5 checksum of the given file
* [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) - removes empty subfolders within the given directory tree
* [search-files.ps1](Scripts/search-files.ps1) - searches the given pattern in the given files
* [SHA1.ps1](Scripts/SHA1.ps1) - prints the SHA1 checksum of the given file
* [SHA256.ps1](Scripts/SHA256.ps1) - prints the SHA256 checksum of the given file
* [show-dir-tree.ps1](Scripts/show-dir-tree.ps1) - visualizes the given/current directory tree
* [zip-dir.ps1](Scripts/zip-dir.ps1) - creates a zip archive of the given directory

Scripts for Git 📝
-----------------
* [clean-branch.ps1](Scripts/clean-branch.ps1) - cleans the current Git branch (including submodules) from generated files
* [clone-repos.ps1](Scripts/clone-repos.ps1) - clones well-known Git repositories
* [configure-git.ps1](Scripts/configure-git.ps1) - sets up the Git user configuration
* [fetch-repos.ps1](Scripts/fetch-repos.ps1) - fetches all Git repositories under the current/given directory (including submodules)
* [switch-branch.ps1](Scripts/switch-branch.ps1) - switches the current Git repository to the given branch (including submodules)
* [update-repos.ps1](Scripts/update-repos.ps1) - updates all Git repositories under the current/given directory (including submodules)

Scripts for PowerShell 🔎
------------------------
* [daily-tasks.sh](Scripts/daily-tasks.sh) - execute PowerShell scripts automatically as daily tasks (Linux only)
* [list-aliases.ps1](Scripts/list-aliases.ps1) - lists all PowerShell aliases 
* [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) - lists the automatic variables of PowerShell 
* [list-cmdlets.ps1](Scripts/list-cmdlets.ps1) - lists the PowerShell cmdlets
* [list-modules.ps1](Scripts/list-modules.ps1) - lists the PowerShell modules
* [list-profiles.ps1](Scripts/list-profiles.ps1) - lists your PowerShell profiles
* [list-scripts.ps1](Scripts/list-scripts.ps1) - lists all PowerShell scripts in this repository
* [set-profile.ps1](Scripts/set-profile.ps1) - updates your PowerShell user profile

Various Scripts 🛒
-----------------
* [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1) - checks the given IPv4 address for validity
* [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1) - checks the given IPv6 address for validity
* [check-mac-address.ps1](Scripts/check-mac-address.ps1) - checks the given MAC address for validity
* [csv-to-text.ps1](Scripts/csv-to-text.ps1) - converts the given CSV file into a text list
* [display-time.ps1](Scripts/display-time.ps1) - displays the current time for 10 seconds by default
* [download.ps1](Scripts/download.ps1) - downloads the file/directory from the given URL
* [generate-qrcode.ps1](Scripts/generate-qrcode.ps1) - generates a QR code
* [list-anagrams.ps1](Scripts/list-anagrams.ps1) - lists all anagrams of the given word
* [list-environment-variables.ps1](Scripts/list-environment-variables.ps1) - lists all environment variables
* [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1) - lists the FRITZ!Box calls
* [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1) - lists FRITZ!Box's known devices 
* [list-logbook.ps1](Scripts/list-logbook.ps1) - lists the content of the logbook 
* [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) - lists earthquakes with magnitude >= 6.0 for the last 30 days
* [list-news.ps1](Scripts/list-news.ps1) - lists the latest news
* [list-os-releases.ps1](Scripts/list-os-releases.ps1) - lists OS releases and download URL
* [list-random-passwords.ps1](Scripts/list-random-passwords.ps1) - prints a list of random passwords
* [list-random-pins.ps1](Scripts/list-random-pins.ps1) - prints a list of random PIN's
* [locate-city.ps1](Scripts/locate-city.ps1) - prints the geographic location of the given city
* [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) - prints the geographic location of the given IP address
* [locate-zip-code.ps1](Scripts/locate-zip-code.ps1) - prints the geographic location of the given zip-code
* [moon.ps1](Scripts/moon.ps1) - prints the current moon phase
* [next-joke.ps1](Scripts/next-joke.ps1) - gets the next random Juck Norris joke
* [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1) - reboots the FRITZ!box device
* [scan-ports.ps1](Scripts/scan-ports.ps1) - scans the network for open/closed ports
* [send-email.ps1](Scripts/send-email.ps1) - sends an email message
* [send-tcp.ps1](Scripts/send-udp.ps1) - sends a TCP message to the given IP address and port
* [send-udp.ps1](Scripts/send-udp.ps1) - sends a UDP datagram message to the given IP address and port
* [set-timer.ps1](Scripts/set-timer.ps1) - sets a timer for a countdown
* [simulate-matrix.ps1](Scripts/simulate-matrix.ps1) - simulates the Matrix (fun)
* [simulate-presence.ps1](Scripts/simulate-presence.ps1) - simulates the human presence against burglars
* [switch-shelly1.ps1](Scripts/switch-shelly1.ps1) - switches a Shelly1 device in the local network
* [train-dns-cache.ps1](Scripts/train-dns-cache.ps1) - trains the DNS cache with frequently used domain names
* [translate-text.ps1](Scripts/translate-text.ps1) - translates the given text into other languages
* [weather.ps1](Scripts/weather.ps1) - prints the current weather forecast
* [weather-alert.ps1](Scripts/weather-alert.ps1) - checks the current weather for critical values
* [weather-report.ps1](Scripts/weather-report.ps1) - prints the local weather report
* [weather-worldwide.ps1](Scripts/weather-worldwide.ps1) - prints the current weather of cities worldwide
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

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
