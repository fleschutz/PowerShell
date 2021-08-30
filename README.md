Mega Collection of PowerShell Scripts
=====================================

**This repository provides more than 200 useful and cross-platform PowerShell scripts in the [Scripts](Scripts/) subfolder - to be used by command-line interface (CLI), for remote control (e.g. via SSH), by context menu, by voice control, by automation software like Jenkins, automatically as daily tasks, or simply to learn PowerShell. See the [PowerShell FAQ page](Docs/FAQ.md) if you need help or have any questions.**

**Note:** the scripts fully support Unicode I/O. It's recommended to use a modern console supporting UTF-8 (e.g. Windows Terminal).

🔊 Scripts for Audio & Voice 
-----------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [mute-audio.ps1](Scripts/mute-audio.ps1)             | Mutes the audio device                                             | [Manual](Docs/mute-audio.ps1.md)        |
| [list-voices.ps1](Scripts/list-voices.ps1)           | Lists the installed text-to-speech (TTS) voices                    | [Manual](Docs/list-voices.ps1.md)       |
| [play-beep.ps1](Scripts/play-beep.ps1)               | Plays a beep sound                                                 | [Manual](Docs/play-beep.ps1.md)         |
| [play-files.ps1](Scripts/play-files.ps1)             | Plays the given audio files                                        | [Manual](Docs/play-files.ps1.md)        |
| [play-happy-birthday.ps1](Scripts/play-happy-birthday.ps1) | Plays the Happy Birthday song                                | [Manual](Docs/play-happy-birthday.ps1.md) |
| [play-imperial-march.ps1](Scripts/play-imperial-march.ps1) | Plays the Imperial March (Star Wars)                         | [Manual](Docs/play-imperial-march.ps1.md) |
| [play-jingle-bells.ps1](Scripts/play-jingle-bells.ps1) | Plays Jingle Bells                                               | [Manual](Docs/play-jingle-bells.ps1.md) |
| [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) | Plays the Mission Impossible theme                   | [Manual](Docs/play-mission-impossible.ps1.md) |
| [play-m3u.ps1](Scripts/play-m3u.ps1)                 | Plays the given playlist (M3U file format)                         | [Manual](Docs/play-m3u.ps1.md)          |
| [play-mp3.ps1](Scripts/play-mp3.ps1)                 | Plays the given sound file (MP3 file format)                       | [Manual](Docs/play-mp3.ps1.md)          |
| [play-super-mario.ps1](Scripts/play-super-mario.ps1) | Plays the Super Mario Intro                                        | [Manual](Docs/play-super-mario.ps1.md)  |
| [play-tetris-melody.ps1](Scripts/play-tetris-melody.ps1) | Plays the Tetris melody                                        | [Manual](Docs/play-tetris-melody.ps1.md) |
| [speak-checklist.ps1](Scripts/speak-checklist.ps1)   | Speaks the given checklist by text-to-speech (TTS)                 | [Manual](Docs/speak-checklist.ps1.md)   |
| [speak-countdown.ps1](Scripts/speak-countdown.ps1)   | Starts a countdown by text-to-speech (TTS)                         | [Manual](Docs/speak-countdown.ps1.md)   |
| [speak-date.ps1](Scripts/speak-date.ps1)             | Speaks the current date by text-to-speech (TTS)                    | [Manual](Docs/speak-date.ps1.md)        |
| [speak-english.ps1](Scripts/speak-english.ps1)       | Speaks the given text with an English text-to-speech (TTS) voice   | [Manual](Docs/speak-english.ps1.md)     |
| [speak-epub.ps1](Scripts/speak-epub.ps1)             | Speaks the content of the given Epub file by text-to-speech (TTS)  | [Manual](Docs/speak-epub.ps1.md)        |
| [speak-file.ps1](Scripts/speak-file.ps1)             | Speaks the content of the given text file by text-to-speech (TTS)  | [Manual](Docs/speak-file.ps1.md)        |
| [speak-french.ps1](Scripts/speak-french.ps1)         | Speaks the given text with a French text-to-speech (TTS) voice     | [Manual](Docs/speak-french.ps1.md)      |
| [speak-german.ps1](Scripts/speak-german.ps1)         | Speaks the given text with a German text-to-speech (TTS) voice     | [Manual](Docs/speak-german.ps1.md)      |
| [speak-italian.ps1](Scripts/speak-italian.ps1)       | Speaks the given text with an Italian text-to-speech (TTS) voice   | [Manual](Docs/speak-italian.ps1.md)     |
| [speak-joke.ps1](Scripts/speak-joke.ps1)             | Speaks a random Chuck Norris joke by text-to-speech (TTS)          | [Manual](Docs/speak-joke.ps1.md)        |
| [speak-quote.ps1](Scripts/speak-quote.ps1)           | Speaks a random quote by text-to-speech (TTS)                      | [Manual](Docs/speak-quote.ps1.md)       |
| [speak-spanish.ps1](Scripts/speak-spanish.ps1)       | Speaks the given text with a Spanish text-to-speech (TTS) voice    | [Manual](Docs/speak-spanish.ps1.md)     |
| [speak-test.ps1](Scripts/speak-test.ps1)             | Performs a speak test by text-to-speech (TTS)                      | [Manual](Docs/speak-test.ps1.md)        |
| [speak-text.ps1](Scripts/speak-text.ps1)             | Speaks the given text by text-to-speech (TTS)                      | [Manual](Docs/speak-text.ps1.md)        |
| [speak-time.ps1](Scripts/speak-time.ps1)             | Speaks the current time by text-to-speech (TTS)                    | [Manual](Docs/speak-time.ps1.md)        |
| [turn-volume-up.ps1](Scripts/turn-volume-up.ps1)     | Turns the audio volume up (+10% by default)                        | [Manual](Docs/turn-volume-up.ps1.md)    |
| [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) | Turns the audio volume down (-10% by default)                      | [Manual](Docs/turn-volume-down.ps1.md)  |
| [unmute-audio.ps1](Scripts/unmute-audio.ps1)         | Unmutes the audio device                                           | [Manual](Docs/unmute-audio.ps1.md)      |
| [voice-control.ps1](Scripts/voice-control.ps1)       | Executes the PowerShell scripts by voice                           | [Manual](Docs/voice-control.ps1.md)     |

⚙️ Scripts to Manage Computers
-------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) | Adds firewall rules for the given executables (needs admin rights)
| [check-cpu-temp.ps1](Scripts/check-cpu-temp.ps1)     | Checks the CPU temperature
| [check-dns-resolution.ps1](Scripts/check-dns-resolution.ps1) | Checks the DNS resolution with frequently used domain names
| [check-drive-space.ps1](Scripts/check-drive-space.ps1) | Checks the given drive for free space left
| [check-file-system.ps1](Scripts/check-file-system.ps1) | Checks the validity of the file system (needs admin rights)
| [check-health.ps1](Scripts/check-health.ps1)         | Checks the system health
| [check-ping.ps1](Scripts/check-ping.ps1)             | Checks the ping latency to the internet
| [check-swap-space.ps1](Scripts/check-swap-space.ps1) | Checks the swap space for free space left
| [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) | Checks the validity of the Windows system files (needs admin rights)
| [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) | Enables the writing of crash dumps
| [hibernate.ps1](Scripts/hibernate.ps1)               | Enables hibernate mode for the local computer (needs admin rights)
| [install-github-cli.ps1](Scripts/install-github-cli.ps1) | Installs GitHub CLI
| [install-google-chrome.ps1](Scripts/install-google-chrome.ps1) | Installs the Google Chrome browser
| [install-knot-resolver.ps1](Scripts/install-knot-resolver.ps1) | Installs the Knot Resolver (needs admin rights)
| [install-ssh-client.ps1](Scripts/install-ssh-client.ps1) | Installs the SSH client (needs admin rights)
| [install-ssh-server.ps1](Scripts/install-ssh-server.ps1) | Installs the SSH server (needs admin rights)
| [install-signal-cli.ps1](Scripts/install-signal-cli.ps1) | Installs signal-cli from github.com/AsamK/signal-cli
| [install-wsl.ps1](Scripts/install-wsl.ps1)           | Installs Windows Subsystem for Linux (WSL), needs admin rights
| [list-cli-tools.ps1](Scripts/list-cli-tools.ps1)     | Lists available command-line interface (CLI) tools 
| [list-drives.ps1](Scripts/list-drives.ps1)           | Lists all drives
| [list-network-shares.ps1](Scripts/list-network-shares.ps1) | Lists the network shares of the local computer
| [list-installed-apps.ps1](Scripts/list-installed-apps.ps1) | Lists the installed Windows Store apps
| [list-installed-software.ps1](Scripts/list-installed-software.ps1) | Lists the installed software (except Windows Store apps)
| [list-printers.ps1](Scripts/list-printers.ps1)       | Lists all printer known to the computer
| [list-print-jobs.ps1](Scripts/list-print-jobs.ps1) | Lists all jobs of all printers
| [list-processes.ps1](Scripts/list-processes.ps1)     | Lists the local computer processes
| [list-services.ps1](Scripts/list-services.ps1)       | Lists the services on the local computer
| [list-system-info.ps1](Scripts/list-system-info.ps1) | Lists system information on the local computer
| [list-tasks.ps1](Scripts/list-tasks.ps1)             | Lists all Windows scheduler tasks
| [list-timezone.ps1](Scripts/list-timezone.ps1)       | Lists the current time zone details
| [list-timezones.ps1](Scripts/list-timezones.ps1)     | Lists all time zones available 
| [list-user-groups.ps1](Scripts/list-user-groups.ps1) | Lists the user groups on the local computer
| [poweroff.ps1](Scripts/poweroff.ps1)                 | Halts the local computer (needs admin rights)
| [query-smart-data.ps1](Scripts/query-smart-data.ps1) | Queries the S.M.A.R.T. data of your HDD/SSD's 
| [reboot.ps1](Scripts/reboot.ps1)                     | Reboots the local computer (needs admin rights)
| [remove-print-jobs.ps1](Scripts/remove-print-jobs.ps1) | Removes all jobs from all printers
| [restart-network-adapters.ps1](Scripts/restart-network-adapters.ps1) | Restarts all local network adapters
| [upgrade-ubuntu.ps1](Scripts/upgrade-ubuntu.ps1)     | Upgrades Ubuntu Linux to the latest (LTS) release 
| [wakeup.ps1](Scripts/wakeup.ps1)                     | Sends a magic packet a computer to wake him up

💻 Scripts for the Desktop
---------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [close-calculator.ps1](Scripts/close-calculator.ps1) | Closes the calculator program gracefully
| [close-chrome.ps1](Scripts/close-chrome.ps1)         | Closes Google Chrome gracefully
| [close-cortana.ps1](Scripts/close-cortana.ps1)       | Closes Cortana gracefully
| [close-edge.ps1](Scripts/close-edge.ps1)             | Closes Microsoft Edge gracefully
| [close-file-explorer.ps1](Scripts/close-file-explorer.ps1) | Closes Microsoft File Explorer gracefully
| [close-firefox.ps1](Scripts/close-firefox.ps1)       | Closes the Firefox Web browser gracefully
| [close-program.ps1](Scripts/close-program.ps1)       | Closes the given program gracefully
| [close-netflix.ps1](Scripts/close-netflix.ps1)       | Closes Netflix gracefully
| [close-onedrive.ps1](Scripts/close-onedrive.ps1)     | Closes Microsoft OneDrive gracefully
| [close-system-settings.ps1](Scripts/close-system-settings.ps1) | Closes the System Settings gracefully
| [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) | Closes Mozilla Thunderbird gracefully
| [close-vlc.ps1](Scripts/close-vlc.ps1)               | Closes the VLC media player gracefully
| [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) | Closes Windows Terminal gracefully
| [enable-god-mode.ps1](Scripts/enable-god-mode.ps1)   | Enables the god mode (adds a new icon to the desktop)
| [list-clipboard.ps1](Scripts/list-clipboard.ps1)     | Lists the contents of the clipboard
| [new-email.ps1](Scripts/new-email.ps1)               | Starts the default email client to write a new email
| [open-browser.ps1](Scripts/open-browser.ps1)         | Starts the default Web browser
| [open-calculator.ps1](Scripts/open-calculator.ps1)   | Starts the calculator program
| [open-email-client.ps1](Scripts/open-browser.ps1)    | Starts the default email client
| [open-file-explorer.ps1](Scripts/open-file-explorer.ps1) | Starts the File Explorer
| [open-netflix.ps1](Scripts/open-netflix.ps1)         | Starts the Netflix app
| [open-onedrive.ps1](Scripts/open-onedrive.ps1)       | Opens the user's OneDrive folder 
| [open-recycle-bin.ps1](Scripts/open-recycle-bin.ps1) | Starts the File Explorer with the recycle bin folder
| [set-wallpaper.ps1](Scripts/set-wallpaper.ps1)       | Sets the given image as wallpaper
| [take-screenshot.ps1](Scripts/take-screenshot.ps1)   | Takes a single screenshot
| [take-screenshots.ps1](Scripts/take-screenshots.ps1) | Takes multiple screenshots (every minute by default)

📁 Scripts for Files & Folders 
-------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [cd-desktop.ps1](Scripts/cd-desktop.ps1)             | Go to the user's desktop folder
| [cd-docs.ps1](Scripts/cd-docs.ps1)                   | Go to the user's documents folder
| [cd-downloads.ps1](Scripts/cd-downloads.ps1)         | Go to the user's downloads folder
| [cd-dropbox.ps1](Scripts/cd-dropbox.ps1)             | Go to the user's Dropbox folder
| [cd-home.ps1](Scripts/cd-home.ps1)                   | Go to the user's home folder
| [cd-music.ps1](Scripts/cd-music.ps1)                 | Go to the user's music folder
| [cd-onedrive.ps1](Scripts/cd-onedrive.ps1)           | Go to the user's OneDrive folder
| [cd-pics.ps1](Scripts/cd-pics.ps1)                   | Go to the user's pictures folder
| [cd-recycle-bin.ps1](Scripts/cd-recycle-bin.ps1)     | Go to the user's recycle bin folder
| [cd-repos.ps1](Scripts/cd-repos.ps1)                 | Go to the user's Git repositories folder
| [cd-root.ps1](Scripts/cd-root.ps1)                   | Go to the root directory (C:\ on Windows)
| [cd-scripts.ps1](Scripts/cd-scripts.ps1)             | Go to the PowerShell Scripts folder
| [cd-up.ps1](Scripts/cd-up.ps1)                       | Go one directory level up
| [cd-up2.ps1](Scripts/cd-up2.ps1)                     | Go two directory levels up
| [cd-up3.ps1](Scripts/cd-up3.ps1)                     | Go three directory levels up
| [cd-up4.ps1](Scripts/cd-up4.ps1)                     | Go four directory levels up
| [cd-videos.ps1](Scripts/cd-videos.ps1)               | Go to the user's videos folder
| [check-symlinks.ps1](Scripts/check-symlinks.ps1)     | Checks every symlink in the given directory tree
| [check-xml-file.ps1](Scripts/check-xml-file.ps1)     | Checks the given XML file for validity
| [clear-recycle-bin.ps1](Scripts/clear-recycle-bin.ps1) | Removes the content of the recycle bin folder (can not be undo!)
| [copy-photos-sorted.ps1](Scripts/copy-photos-sorted.ps1) | Copies all photos sorted by year and month 
| [create-shortcut.ps1](Scripts/create-shortcut.ps1)   | Creates a shortcut
| [create-symlink.ps1](Scripts/create-symlink.ps1)     | Creates a symbolic link
| [decrypt-file.ps1](Scripts/decrypt-file.ps1)         | Encrypts the given file
| [download-dir.ps1](Scripts/download-dir.ps1)         | Downloads a directory tree from the given URL
| [download-file.ps1](Scripts/download-file.ps1)       | Downloads a file from the given URL
| [edit.ps1](Scripts/edit.ps1)                         | Edits the given file with the built-in text editor
| [encrypt-file.ps1](Scripts/encrypt-file.ps1)         | Encrypts the given file
| [inspect-exe.ps1](Scripts/inspect-exe.ps1)           | Prints basic information of the given executable file
| [list-dir.ps1](Scripts/list-dir.ps1)                 | Lists the directory content (formatted in columns)
| [list-dir-tree.ps1](Scripts/list-dir-tree.ps1)       | Lists the directory tree content
| [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1)   | Lists empty subfolders within the given directory tree
| [list-empty-files.ps1](Scripts/list-empty-files.ps1) | Lists empty files within the given directory tree
| [list-files.ps1](Scripts/list-files.ps1)             | Lists all files in the given folder and also in every subfolder
| [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) | Lists hidden files within the given directory tree
| [list-recycle-bin.ps1](Scripts/list-recycle-bin.ps1) | Lists the content of the recycle bin folder
| [list-unused-files.ps1](Scripts/list-unused-files.ps1) | Lists unused files in a directory tree
| [list-workdir.ps1](Scripts/list-workdir.ps1)         | Lists the current working directory
| [make-install.ps1](Scripts/make-install.ps1)         | Installs built executables and libs to the installation directory
| [MD5.ps1](Scripts/MD5.ps1)                           | Prints the MD5 checksum of the given file
| [publish-to-ipfs.ps1](Scripts/publish-to-ipfs.ps1)   | Publishes the given files or directory to IPFS
| [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) | Removes empty subfolders within the given directory tree
| [search-filename.ps1](Scripts/search-filename.ps1)   | Searches the directory tree for filenames by given pattern 
| [search-files.ps1](Scripts/search-files.ps1)         | Searches the given pattern in the given files
| [SHA1.ps1](Scripts/SHA1.ps1)                         | Prints the SHA1 checksum of the given file
| [SHA256.ps1](Scripts/SHA256.ps1)                     | Prints the SHA256 checksum of the given file
| [upload-file.ps1](Scripts/zip-dir.ps1)               | Uploads the local file to the given FTP server
| [zip-dir.ps1](Scripts/zip-dir.ps1)                   | Creates a .zip archive of the given directory

♻️ Scripts to Convert Files
---------------------------

| Script                                                 | Description                                                        | Help                                    |
| ------------------------------------------------------ | ------------------------------------------------------------------ | --------------------------------------- |
| [convert-csv2txt.ps1](Scripts/convert-csv2txt.ps1)     | Converts a given .CSV file to a text file                          | [Manual](Docs/convert-csv2txt.ps1.md)   |
| [convert-mysql2csv.ps1](Scripts/convert-mysql2csv.ps1) | Converts a MySQL database table to a .CSV file                     | [Manual](Docs/convert-mysql2csv.ps1.md) |
| [convert-ps2bat.ps1](Scripts/convert-ps2bat.ps1)       | Converts a PowerShell script to a .BAT file                        | [Manual](Docs/convert-ps2bat.ps1.md)    |
| [convert-ps2md.ps1](Scripts/convert-ps2md.ps1)         | Converts the comment-based help of a PowerShell script to Markdown | [Manual](Docs/convert-ps2md.ps1.md)     |
| [convert-sql2csv.ps1](Scripts/convert-sql2csv.ps1)     | Converts a SQL database table to a .CSV file                       | [Manual](Docs/convert-sql2csv.ps1.md)   |
| [convert-txt2wav.ps1](Scripts/convert-txt2wav.ps1)     | Converts a text file to a .WAV audio file                          | [Manual](Docs/convert-txt2wav.ps1.md)   |

📝 Scripts for Git
-------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [cherry-picker.ps1](Scripts/cherry-picker.ps1)       | Cherry-picks a Git commit into multiple branches                   | [Manual](Docs/cherry-picker.ps1.md)     |
| [clean-repo.ps1](Scripts/clean-repo.ps1)             | Cleans a Git repository from untracked files (including submodules) | [Manual](Docs/clean-repo.ps1.md)       |
| [clean-repos.ps1](Scripts/clean-repos.ps1)           | Cleans all Git repositories under a directory from untracked files (including submodules) | [Manual](Docs/clean-repos.ps1.md)   |
| [clone-repos.ps1](Scripts/clone-repos.ps1)           | Clones well-known Git repositories                                 | [Manual](Docs/clone-repos.ps1.md)       |
| [configure-git.ps1](Scripts/configure-git.ps1)       | Sets up the Git user configuration                                 | [Manual](Docs/configure-git.ps1.md)     |
| [create-branch.ps1](Scripts/create-branch.ps1)       | Creates a new branch in a Git repository                           | [Manual](Docs/create-branch.ps1.md)     |
| [create-tag.ps1](Scripts/create-tag.ps1)             | Creates a new tag in a Git repository                              | [Manual](Docs/create-tag.ps1.md)        |
| [fetch-repo.ps1](Scripts/fetch-repo.ps1)             | Fetches updates for a Git repository (including submodules)        | [Manual](Docs/fetch-repo.ps1.md)        |
| [fetch-repos.ps1](Scripts/fetch-repos.ps1)           | Fetches updates for all Git repositories under a directory (including submodules) | [Manual](Docs/fetch-repos.ps1.md)   |
| [list-branches.ps1](Scripts/list-branches.ps1)       | Lists all branches in a Git repository                             | [Manual](Docs/list-branches.ps1.md)     |
| [list-commits.ps1](Scripts/list-commits.ps1)         | Lists all commits in a Git repository                              | [Manual](Docs/list-commits.ps1.md)      |
| [list-latest-tag.ps1](Scripts/list-latest-tag.ps1)   | Lists the latest tag on the current branch in a Git repository     | [Manual](Docs/list-latest-tag.ps1.md)   |
| [list-latest-tags.ps1](Scripts/list-latest-tags.ps1) | Lists the latests tags in all Git repositories under a directory   | [Manual](Docs/list-latest-tags.ps1.md)  |
| [list-submodules.ps1](Scripts/list-submodules.ps1)   | Lists the submodules in a Git repository                           | [Manual](Docs/list-submodules.ps1.md)   |
| [list-tags.ps1](Scripts/list-tags.ps1)               | Lists all tags in a Git repository                                 | [Manual](Docs/list-tags.ps1.md)         |
| [make-repo.ps1](Scripts/make-repo.ps1)               | Builds a Git repository                                            | [Manual](Docs/make-repo.ps1.md)         |
| [make-repos.ps1](Scripts/make-repos.ps1)             | Builds all Git repositories under a directory                      | [Manual](Docs/make-repos.ps1.md)        |
| [pull-repo.ps1](Scripts/pull-repo.ps1)               | Pulls updates for a Git repository (including submodules)          | [Manual](Docs/pull-repo.ps1.md)         |
| [pull-repos.ps1](Scripts/pull-repos.ps1)             | Pulls updates for all Git repositories under a directory (including submodules) | [Manual](Docs/pull-repos.ps1.md) |
| [switch-branch.ps1](Scripts/switch-branch.ps1)       | Switches the branch in a Git repository (including submodules)     | [Manual](Docs/switch-branch.ps1.md)     |
| [sync-repo.ps1](Scripts/sync-repo.ps1)               | Synchronizes a Git repository by push & pull (including submodules) | [Manual](Docs/sync-repo.ps1.md)        |

🔎 Scripts for PowerShell 
------------------------

| Script                                                 | Description                                                        | Help                                    |
| ------------------------------------------------------ | ------------------------------------------------------------------ | --------------------------------------- |
| [daily-tasks.sh](Scripts/daily-tasks.sh)               | Execute PowerShell scripts automatically as daily tasks (Linux only) | [Manual](Docs/daily-tasks.sh.md)      |
| [introduce-powershell.ps1](Scripts/introduce-powershell.ps1) | Introduces PowerShell to new users                           | [Manual](Docs/introduce-powershell.ps1.md) |
| [list-aliases.ps1](Scripts/list-aliases.ps1)           | Lists all PowerShell aliases                                       | [Manual](Docs/list-aliases.ps1.md)      |
| [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) | Lists the automatic variables of PowerShell          | [Manual](Docs/list-automatic-variables.ps1.md) |
| [list-cheat-sheet.ps1](Scripts/list-cheat-sheet.ps1)   | Lists the PowerShell cheat sheet                                   | [Manual](Docs/list-cheat-sheet.ps1.md)  |
| [list-cmdlets.ps1](Scripts/list-cmdlets.ps1)           | Lists the PowerShell cmdlets                                       | [Manual](Docs/list-cmdlets.ps1.md)      |
| [list-console-colors.ps1](Scripts/list-console-colors.ps1) | Lists all console colors                                       | [Manual](Docs/list-console-colors.ps1.md) |
| [list-modules.ps1](Scripts/list-modules.ps1)           | Lists the PowerShell modules                                       | [Manual](Docs/list-modules.ps1.md)      |
| [list-profiles.ps1](Scripts/list-profiles.ps1)         | Lists your PowerShell profiles                                     | [Manual](Docs/list-profiles.ps1.md)     |
| [list-scripts.ps1](Scripts/list-scripts.ps1)           | Lists all PowerShell scripts in this repository                    | [Manual](Docs/list-scripts.ps1.md)      |
| [new-script.ps1](Scripts/new-script.ps1)               | Creates a new PowerShell script                              | [Manual](Docs/new-script.ps1.md)          |
| [set-profile.ps1](Scripts/set-profile.ps1)             | Updates your PowerShell user profile                               | [Manual](Docs/set-profile.ps1.md)       |

🛒 Various PowerShell Scripts 
------------------------------
* [add-memo.ps1](Scripts/add-memo.ps1) - adds the given memo text to $HOME/Memos.csv
* [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1) - checks the given IPv4 address for validity
* [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1) - checks the given IPv6 address for validity
* [check-mac-address.ps1](Scripts/check-mac-address.ps1) - checks the given MAC address for validity
* [check-subnet-mask.ps1](Scripts/check-subnet-mask.ps1) - checks the given subnet mask for validity
* [check-weather.ps1](Scripts/check-weather.ps1) - checks the current weather for critical values
* [display-time.ps1](Scripts/display-time.ps1) - displays the current time for 10 seconds by default
* [generate-qrcode.ps1](Scripts/generate-qrcode.ps1) - generates a QR code
* [list-anagrams.ps1](Scripts/list-anagrams.ps1) - lists all anagrams of the given word
* [list-city-weather.ps1](Scripts/list-city-weather.ps1) - lists the current weather of cities worldwide (west to east)
* [list-countries.ps1](Scripts/list-countries.ps1) - lists details of all countries
* [list-credits.ps1](Scripts/list-credits.ps1) - shows the credits
* [list-crypto-rates.ps1](Scripts/list-crypto-rates.ps1) - lists the current crypto exchange rates 
* [list-environment-variables.ps1](Scripts/list-environment-variables.ps1) - lists all environment variables
* [list-emojis.ps1](Scripts/list-emojis.ps1) - lists the emojis of Unicode 13.0
* [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1) - lists the FRITZ!Box calls
* [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1) - lists FRITZ!Box's known devices 
* [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) - lists earthquakes with magnitude >= 6.0 for the last 30 days
* [list-exchange-rates.ps1](Scripts/list-exchange-rates.ps1) - lists the current exchange rates for the given currency 
* [list-memos.ps1](Scripts/list-memos.ps1) - lists the memos at $HOME/Memos.csv
* [list-mysql-tables.ps1](Scripts/list-mysql-tables.ps1) - lists the MySQL server tables
* [list-news.ps1](Scripts/list-news.ps1) - lists the latest news
* [list-os-releases.ps1](Scripts/list-os-releases.ps1) - lists operating system releases and download URL
* [list-os-updates.ps1](Scripts/list-os-updates.ps1) - lists operating system updates
* [list-passwords.ps1](Scripts/list-passwords.ps1) - prints a list of random passwords
* [list-pins.ps1](Scripts/list-pins.ps1) - prints a list of random PIN's
* [list-sql-tables.ps1](Scripts/list-sql-tables.ps1) - lists the SQL server tables
* [list-tiobe-index.ps1](Scripts/list-tiobe-index.ps1) - lists the TIOBE index of top programming languages
* [list-weather.ps1](Scripts/list-weather.ps1) - lists the hourly weather 
* [locate-city.ps1](Scripts/locate-city.ps1) - prints the geographic location of the given city
* [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) - prints the geographic location of the given IP address
* [locate-zip-code.ps1](Scripts/locate-zip-code.ps1) - prints the geographic location of the given zip-code
* [moon.ps1](Scripts/moon.ps1) - prints the current moon phase
* [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1) - reboots the FRITZ!box device
* [scan-ports.ps1](Scripts/scan-ports.ps1) - scans the network for open/closed ports
* [send-email.ps1](Scripts/send-email.ps1) - sends an email message
* [send-tcp.ps1](Scripts/send-udp.ps1) - sends a TCP message to the given IP address and port
* [send-udp.ps1](Scripts/send-udp.ps1) - sends a UDP datagram message to the given IP address and port
* [set-timer.ps1](Scripts/set-timer.ps1) - sets a timer for a countdown
* [simulate-matrix.ps1](Scripts/simulate-matrix.ps1) - simulates the Matrix (fun)
* [simulate-presence.ps1](Scripts/simulate-presence.ps1) - simulates the human presence against burglars
* [start-calibre-server.ps1](Scripts/start-calibre-server.ps1) - starts a local Calibre server 
* [start-ipfs-server.ps1](Scripts/start-ipfs-server.ps1) - starts a local IPFS server
* [switch-shelly1.ps1](Scripts/switch-shelly1.ps1) - switches a Shelly1 device in the local network
* [translate-file.ps1](Scripts/translate-file.ps1) - translates the given text file into other languages
* [translate-files.ps1](Scripts/translate-files.ps1) - translates the given text files into any supported language
* [translate-text.ps1](Scripts/translate-text.ps1) - translates the given text in English into other languages
* [weather.ps1](Scripts/weather.ps1) - prints the current weather forecast
* [weather-report.ps1](Scripts/weather-report.ps1) - prints the local weather report
* [what-is.ps1](Scripts/what-is.ps1) - prints a description of the given abbreviation
* [write-animated.ps1](Scripts/write-animated.ps1) - writes animated text
* [write-big.ps1](Scripts/write-big.ps1) - writes the given text in big letters
* [write-blue.ps1](Scripts/write-blue.ps1) - writes the given text in a blue foreground color
* [write-braille.ps1](Scripts/write-braille.ps1) - writes the given text in Braille
* [write-green.ps1](Scripts/write-green.ps1) - writes the given text in a green foreground color
* [write-joke.ps1](Scripts/write-joke.ps1) - writes a random Juck Norris joke
* [write-lowercase.ps1](Scripts/write-lowercase.ps1) - writes the given text in lowercase letters
* [write-marquee.ps1](Scripts/write-marquee.ps1) - writes the given text as marquee
* [write-morse-code.ps1](Scripts/write-morse-code.ps1) - writes the given text in Morse code
* [write-motd.ps1](Scripts/write-motd.ps1) - writes the message of the day (MOTD)
* [write-quote.ps1](Scripts/write-quote.ps1) - writes a random quote
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
