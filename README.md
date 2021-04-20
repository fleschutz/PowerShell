Mega Collection of PowerShell Scripts
=====================================

**This repository provides more than 190 useful and cross-platform PowerShell scripts in the subfolder [Scripts/](Scripts/) - to be used by command-line interface (CLI), for remote control (e.g. via SSH), by context menu, by voice control, by automation software like Jenkins, automatically as daily tasks, or simply to learn PowerShell. See the [PowerShell FAQ page](Misc/FAQ.md) if you need help or have any questions.**

**NOTE:** the scripts support and use Unicode characters! Use a modern console supporting UTF-8 such as Windows Terminal

🔊 PowerShell Scripts for Audio & Voice 
----------------------------------------
* [convert-txt2wav.ps1](Scripts/convert-txt2wav.ps1) - converts text to a .WAV audio file
* [mute-audio.ps1](Scripts/mute-audio.ps1) - mutes audio
* [play-beep.ps1](Scripts/play-beep.ps1) - plays a beep sound
* [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) - plays the Mission Impossible theme
* [play-m3u.ps1](Scripts/play-m3u.ps1) - plays the given playlist (M3U file format)
* [play-mp3.ps1](Scripts/play-mp3.ps1) - plays the given sound file (MP3 file format)
* [play-super-mario.ps1](Scripts/play-super-mario.ps1) - plays the Super Mario Intro
* [play-the-imperial-march.ps1](Scripts/play-the-imperial-march.ps1) - plays the Imperial March (Star Wars)
* [speak-countdown.ps1](Scripts/speak-countdown.ps1) - starts a countdown by text-to-speech (TTS)
* [speak-date.ps1](Scripts/speak-date.ps1) - speaks the current date by text-to-speech (TTS)
* [speak-english.ps1](Scripts/speak-english.ps1) - speaks the given text with an English text-to-speech (TTS) voice
* [speak-epub.ps1](Scripts/speak-epub.ps1) - speaks the content of the given Epub file by text-to-speech (TTS)
* [speak-file.ps1](Scripts/speak-file.ps1) - speaks the content of the given text file by text-to-speech (TTS)
* [speak-german.ps1](Scripts/speak-german.ps1) - speaks the given text with a German text-to-speech (TTS) voice
* [speak-joke.ps1](Scripts/speak-joke.ps1) - speaks the next joke by text-to-speech (TTS)
* [speak-test.ps1](Scripts/speak-test.ps1) - performs a speak test by text-to-speech (TTS)
* [speak-text.ps1](Scripts/speak-text.ps1) - speaks the given text by text-to-speech (TTS)
* [speak-time.ps1](Scripts/speak-time.ps1) - speaks the current time by text-to-speech (TTS)
* [turn-volume-up.ps1](Scripts/turn-volume-up.ps1) - turns the audio volume up (+10% by default)
* [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) - turns the audio volume down (-10% by default)
* [unmute-audio.ps1](Scripts/unmute-audio.ps1) - unmutes audio
* [voice-control.ps1](Scripts/voice-control.ps1) - executes the PowerShell scripts by voice

⚙️ PowerShell Scripts for Computer Management
----------------------------------------------
* [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) - adds firewall rules for the given executables (needs admin rights)
* [check-cpu-temp.ps1](Scripts/check-cpu-temp.ps1) - checks the CPU temperature
* [check-dns-resolution.ps1](Scripts/check-dns-resolution.ps1) - checks the DNS resolution with frequently used domain names
* [check-drive-space.ps1](Scripts/check-drive-space.ps1) - checks the given drive for free space left
* [check-file-system.ps1](Scripts/check-file-system.ps1) - checks the validity of the file system (needs admin rights)
* [check-health.ps1](Scripts/check-health.ps1) - checks the system health
* [check-ping.ps1](Scripts/check-ping.ps1) - checks the ping latency to the internet
* [check-swap-space.ps1](Scripts/check-swap-space.ps1) - checks the swap space for free space left
* [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) - checks the validity of the Windows system files (needs admin rights)
* [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) - enables the writing of crash dumps
* [enable-ssh-client.ps1](Scripts/enable-ssh-client.ps1) - enables the SSH client (needs admin rights)
* [enable-ssh-server.ps1](Scripts/enable-ssh-server.ps1) - enables the SSH server (needs admin rights)
* [hibernate.ps1](Scripts/hibernate.ps1) - enables hibernate mode for the local computer (needs admin rights)
* [install-google-chrome.ps1](Scripts/install-google-chrome.ps1) - installs the Google Chrome browser
* [list-drives.ps1](Scripts/list-drives.ps1) - lists all drives
* [list-network-shares.ps1](Scripts/list-network-shares.ps1) - lists the network shares of the local computer
* [list-installed-apps.ps1](Scripts/list-installed-apps.ps1) - lists the installed Windows Store apps
* [list-installed-software.ps1](Scripts/list-installed-software.ps1) - lists the installed software (except Windows Store apps)
* [list-printers.ps1](Scripts/list-printers.ps1) - lists all printer known to the computer
* [list-processes.ps1](Scripts/list-processes.ps1) - lists the local computer processes
* [list-services.ps1](Scripts/list-services.ps1) - lists the services on the local computer
* [list-system-info.ps1](Scripts/list-system-info.ps1) - lists system information on the local computer
* [list-tasks.ps1](Scripts/list-tasks.ps1) - lists all Windows scheduler tasks
* [list-timezone.ps1](Scripts/list-timezone.ps1) - lists the current time zone details
* [list-timezones.ps1](Scripts/list-timezones.ps1) - lists all time zones available 
* [list-user-groups.ps1](Scripts/list-user-groups.ps1) - lists the user groups on the local computer
* [poweroff.ps1](Scripts/poweroff.ps1) - halts the local computer (needs admin rights)
* [query-smart-data.ps1](Scripts/query-smart-data.ps1) - queries the S.M.A.R.T. data of your HDD/SSD's 
* [reboot.ps1](Scripts/reboot.ps1) - reboots the local computer (needs admin rights)
* [wakeup.ps1](Scripts/wakeup.ps1) - sends a magic packet to the given computer, waking him up

💻 PowerShell Scripts for the Desktop
--------------------------------------
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
* [enable-god-mode.ps1](Scripts/enable-god-mode.ps1) - enables the god mode (adds a new icon to the desktop)
* [list-clipboard.ps1](Scripts/list-clipboard.ps1) - lists the contents of the clipboard
* [new-email.ps1](Scripts/new-email.ps1) - starts the default email client to write a new email
* [open-browser.ps1](Scripts/open-browser.ps1) - starts the default Web browser
* [open-calculator.ps1](Scripts/open-calculator.ps1) - starts the calculator program
* [open-email-client.ps1](Scripts/open-browser.ps1) - starts the default email client
* [open-file-explorer.ps1](Scripts/open-file-explorer.ps1) - starts the File Explorer
* [set-wallpaper.ps1](Scripts/set-wallpaper.ps1) - sets the given image as wallpaper
* [take-screenshot.ps1](Scripts/take-screenshot.ps1) - takes a single screenshot
* [take-screenshots.ps1](Scripts/take-screenshots.ps1) - takes multiple screenshots (every minute by default)

📁 PowerShell Scripts for Files & Folders 
------------------------------------------
* [check-symlinks.ps1](Scripts/check-symlinks.ps1) - checks every symlink in the given directory tree
* [check-xml-file.ps1](Scripts/check-xml-file.ps1) - checks the given XML file for validity
* [create-shortcut.ps1](Scripts/create-shortcut.ps1) - creates a shortcut
* [create-symlink.ps1](Scripts/create-symlink.ps1) - creates a symbolic link
* [decrypt-file.ps1](Scripts/decrypt-file.ps1) - encrypts the given file
* [download-dir.ps1](Scripts/download-dir.ps1) - downloads a directory tree from the given URL
* [download-file.ps1](Scripts/download-file.ps1) - downloads a file from the given URL
* [edit.ps1](Scripts/edit.ps1) - edits the given file with the built-in text editor
* [encrypt-file.ps1](Scripts/encrypt-file.ps1) - encrypts the given file
* [go-desktop.ps1](Scripts/go-desktop.ps1) - go to the user's desktop folder
* [go-downloads.ps1](Scripts/go-downloads.ps1) - go to the user's downloads folder
* [go-dropbox.ps1](Scripts/go-dropbox.ps1) - go to the user's dropbox folder
* [go-home.ps1](Scripts/go-home.ps1) - go to the user's home folder
* [go-music.ps1](Scripts/go-music.ps1) - go to the user's music folder
* [go-repos.ps1](Scripts/go-repos.ps1) - go to the user's Git repositories folder
* [go-root.ps1](Scripts/go-root.ps1) - go to the root directory (C:\ on Windows)
* [go-scripts.ps1](Scripts/go-scripts.ps1) - go to the PowerShell Scripts folder
* [inspect-exe.ps1](Scripts/inspect-exe.ps1) - prints basic information of the given executable file
* [list-dir-tree.ps1](Scripts/list-dir-tree.ps1) - lists a directory tree
* [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1) - lists empty subfolders within the given directory tree
* [list-empty-files.ps1](Scripts/list-empty-files.ps1) - lists empty files within the given directory tree
* [list-files.ps1](Scripts/list-files.ps1) - lists all files in the given folder and also in every subfolder
* [list-formatted.ps1](Scripts/list-formatted.ps1) - lists the current working directory formatted in columns
* [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) - lists hidden files within the given directory tree
* [list-unused-files.ps1](Scripts/list-unused-files.ps1) - lists unused files in a directory tree
* [list-workdir.ps1](Scripts/list-workdir.ps1) - lists the current working directory
* [make-install.ps1](Scripts/make-install.ps1) - installs built executables and libs to the installation directory
* [MD5.ps1](Scripts/MD5.ps1) - prints the MD5 checksum of the given file
* [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) - removes empty subfolders within the given directory tree
* [search-filename.ps1](Scripts/search-filename.ps1) - searches the directory tree for filenames by given pattern 
* [search-files.ps1](Scripts/search-files.ps1) - searches the given pattern in the given files
* [SHA1.ps1](Scripts/SHA1.ps1) - prints the SHA1 checksum of the given file
* [SHA256.ps1](Scripts/SHA256.ps1) - prints the SHA256 checksum of the given file
* [upload-file.ps1](Scripts/zip-dir.ps1) - uploads the local file to the given FTP server
* [zip-dir.ps1](Scripts/zip-dir.ps1) - creates a zip archive of the given directory

📝 PowerShell Scripts for Git
------------------------------
* [build-repo.ps1](Scripts/build-repo.ps1) - builds the current/given Git repository 
* [build-repos.ps1](Scripts/build-repos.ps1) - builds all Git repositories under the current/given directory
* [cherry-picker.ps1](Scripts/cherry-picker.ps1) - cherry-picks a Git commit into multiple branches
* [clean-repo.ps1](Scripts/clean-repo.ps1) - cleans the current/given Git repository from untracked files (including submodules)
* [clone-repos.ps1](Scripts/clone-repos.ps1) - clones well-known Git repositories
* [configure-git.ps1](Scripts/configure-git.ps1) - sets up the Git user configuration
* [create-branch.ps1](Scripts/create-branch.ps1) - creates a new branch in the current/given Git repository 
* [create-tag.ps1](Scripts/create-tag.ps1) - creates a new tag in the current/given Git repository 
* [fetch-repo.ps1](Scripts/fetch-repo.ps1) - fetches updates for the current/given Git repository (including submodules)
* [fetch-repos.ps1](Scripts/fetch-repos.ps1) - fetches updates for all Git repositories under the current/given directory (including submodules)
* [list-branches.ps1](Scripts/list-branches.ps1) - lists all branches in the current/given Git repository 
* [list-commits.ps1](Scripts/list-commits.ps1) - lists all commits in the current/given Git repository 
* [list-tags.ps1](Scripts/list-tags.ps1) - lists all tags in the current/given Git repository 
* [pull-repo.ps1](Scripts/pull-repo.ps1) - pulls updates for the current/given Git repository (including submodules)
* [pull-repos.ps1](Scripts/pull-repos.ps1) - pulls updates for all Git repositories under the current/given directory (including submodules)
* [switch-branch.ps1](Scripts/switch-branch.ps1) - switches the branch in the current/given Git repository (including submodules)
* [sync-repo.ps1](Scripts/sync-repo.ps1) - synchronizes a Git repository (pull&push, including submodules)

🔎 Scripts for PowerShell 
------------------------
* [daily-tasks.sh](Scripts/daily-tasks.sh) - execute PowerShell scripts automatically as daily tasks (Linux only)
* [introduce-powershell.sh](Scripts/introduce-powershell.sh) - introduces PowerShell to new users
* [list-aliases.ps1](Scripts/list-aliases.ps1) - lists all PowerShell aliases 
* [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) - lists the automatic variables of PowerShell 
* [list-cheat-sheet.ps1](Scripts/list-cheat-sheet.ps1) - lists the PowerShell cheat sheet
* [list-cmdlets.ps1](Scripts/list-cmdlets.ps1) - lists the PowerShell cmdlets
* [list-modules.ps1](Scripts/list-modules.ps1) - lists the PowerShell modules
* [list-profiles.ps1](Scripts/list-profiles.ps1) - lists your PowerShell profiles
* [list-scripts.ps1](Scripts/list-scripts.ps1) - lists all PowerShell scripts in this repository
* [set-profile.ps1](Scripts/set-profile.ps1) - updates your PowerShell user profile

🛒 Various PowerShell Scripts 
------------------------------
* [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1) - checks the given IPv4 address for validity
* [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1) - checks the given IPv6 address for validity
* [check-mac-address.ps1](Scripts/check-mac-address.ps1) - checks the given MAC address for validity
* [check-weather.ps1](Scripts/check-weather.ps1) - checks the current weather for critical values
* [convert-csv2txt.ps1](Scripts/convert-csv2txt.ps1) - converts the given CSV file to a text list
* [convert-mysql2csv.ps1](Scripts/convert-mysql2csv.ps1) - converts the MySQL database table to a CSV file
* [convert-sql2csv.ps1](Scripts/convert-sql2csv.ps1) - converts the SQL database table to a CSV file
* [display-time.ps1](Scripts/display-time.ps1) - displays the current time for 10 seconds by default
* [generate-qrcode.ps1](Scripts/generate-qrcode.ps1) - generates a QR code
* [list-anagrams.ps1](Scripts/list-anagrams.ps1) - lists all anagrams of the given word
* [list-city-weather.ps1](Scripts/list-city-weather.ps1) - lists the current weather of cities worldwide (west to east)
* [list-environment-variables.ps1](Scripts/list-environment-variables.ps1) - lists all environment variables
* [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1) - lists the FRITZ!Box calls
* [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1) - lists FRITZ!Box's known devices 
* [list-hourly-weather.ps1](Scripts/list-hourly-weather.ps1) - lists the hourly weather today
* [list-logbook.ps1](Scripts/list-logbook.ps1) - lists the content of the logbook 
* [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) - lists earthquakes with magnitude >= 6.0 for the last 30 days
* [list-mysql-tables.ps1](Scripts/list-mysql-tables.ps1) - lists the MySQL server tables
* [list-news.ps1](Scripts/list-news.ps1) - lists the latest news
* [list-os-releases.ps1](Scripts/list-os-releases.ps1) - lists OS releases and download URL
* [list-random-passwords.ps1](Scripts/list-random-passwords.ps1) - prints a list of random passwords
* [list-random-pins.ps1](Scripts/list-random-pins.ps1) - prints a list of random PIN's
* [list-sql-tables.ps1](Scripts/list-sql-tables.ps1) - lists the SQL server tables
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
* [translate-file.ps1](Scripts/translate-file.ps1) - translates the given text file into other languages
* [translate-files.ps1](Scripts/translate-files.ps1) - translates the given text files into any supported language
* [translate-text.ps1](Scripts/translate-text.ps1) - translates the given text in English into other languages
* [weather.ps1](Scripts/weather.ps1) - prints the current weather forecast
* [weather-report.ps1](Scripts/weather-report.ps1) - prints the local weather report
* [write-animated.ps1](Scripts/write-animated.ps1) - writes animated text
* [write-big.ps1](Scripts/write-big.ps1) - writes the given text in big letters
* [write-blue.ps1](Scripts/write-blue.ps1) - writes the given text in a blue foreground color
* [write-braille.ps1](Scripts/write-braille.ps1) - writes the given text in Braille
* [write-green.ps1](Scripts/write-green.ps1) - writes the given text in a green foreground color
* [write-logbook.ps1](Scripts/write-logbook.ps1) - writes the given text to the logbook
* [write-lowercase.ps1](Scripts/write-lowercase.ps1) - writes the given text in lowercase letters
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
