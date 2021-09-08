Mega Collection of PowerShell Scripts
=====================================

**This repository provides more than 250 useful and cross-platform PowerShell scripts in the [Scripts](Scripts/) subfolder - to be used by command-line interface (CLI), for remote control (e.g. via SSH), by context menu, by voice control, by automation software like Jenkins, automatically as daily tasks, or simply to learn PowerShell. See the [PowerShell FAQ page](Docs/FAQ.md) if you need help or have any questions.**

**Note:** the scripts fully support Unicode I/O. It's recommended to use a modern console supporting UTF-8 (e.g. Windows Terminal).

🔊 Scripts for Audio & Voice 
-----------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [mute-audio.ps1](Scripts/mute-audio.ps1)             | Mutes the audio device                                             | [Help](Docs/mute-audio.ps1.md)        |
| [list-voices.ps1](Scripts/list-voices.ps1)           | Lists the installed text-to-speech (TTS) voices                    | [Help](Docs/list-voices.ps1.md)       |
| [play-beep.ps1](Scripts/play-beep.ps1)               | Plays a beep sound                                                 | [Help](Docs/play-beep.ps1.md)         |
| [play-files.ps1](Scripts/play-files.ps1)             | Plays the given audio files                                        | [Help](Docs/play-files.ps1.md)        |
| [play-happy-birthday.ps1](Scripts/play-happy-birthday.ps1) | Plays the Happy Birthday song                                | [Help](Docs/play-happy-birthday.ps1.md) |
| [play-imperial-march.ps1](Scripts/play-imperial-march.ps1) | Plays the Imperial March (Star Wars)                         | [Help](Docs/play-imperial-march.ps1.md) |
| [play-jingle-bells.ps1](Scripts/play-jingle-bells.ps1) | Plays Jingle Bells                                               | [Help](Docs/play-jingle-bells.ps1.md) |
| [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) | Plays the Mission Impossible theme                   | [Help](Docs/play-mission-impossible.ps1.md) |
| [play-m3u.ps1](Scripts/play-m3u.ps1)                 | Plays the given playlist (M3U file format)                         | [Help](Docs/play-m3u.ps1.md)          |
| [play-mp3.ps1](Scripts/play-mp3.ps1)                 | Plays the given sound file (MP3 file format)                       | [Help](Docs/play-mp3.ps1.md)          |
| [play-super-mario.ps1](Scripts/play-super-mario.ps1) | Plays the Super Mario Intro                                        | [Help](Docs/play-super-mario.ps1.md)  |
| [play-tetris-melody.ps1](Scripts/play-tetris-melody.ps1) | Plays the Tetris melody                                        | [Help](Docs/play-tetris-melody.ps1.md) |
| [speak-checklist.ps1](Scripts/speak-checklist.ps1)   | Speaks the given checklist by text-to-speech (TTS)                 | [Help](Docs/speak-checklist.ps1.md)   |
| [speak-countdown.ps1](Scripts/speak-countdown.ps1)   | Starts a countdown by text-to-speech (TTS)                         | [Help](Docs/speak-countdown.ps1.md)   |
| [speak-date.ps1](Scripts/speak-date.ps1)             | Speaks the current date by text-to-speech (TTS)                    | [Help](Docs/speak-date.ps1.md)        |
| [speak-english.ps1](Scripts/speak-english.ps1)       | Speaks the given text with an English text-to-speech (TTS) voice   | [Help](Docs/speak-english.ps1.md)     |
| [speak-epub.ps1](Scripts/speak-epub.ps1)             | Speaks the content of the given Epub file by text-to-speech (TTS)  | [Help](Docs/speak-epub.ps1.md)        |
| [speak-file.ps1](Scripts/speak-file.ps1)             | Speaks the content of the given text file by text-to-speech (TTS)  | [Help](Docs/speak-file.ps1.md)        |
| [speak-french.ps1](Scripts/speak-french.ps1)         | Speaks the given text with a French text-to-speech (TTS) voice     | [Help](Docs/speak-french.ps1.md)      |
| [speak-german.ps1](Scripts/speak-german.ps1)         | Speaks the given text with a German text-to-speech (TTS) voice     | [Help](Docs/speak-german.ps1.md)      |
| [speak-italian.ps1](Scripts/speak-italian.ps1)       | Speaks the given text with an Italian text-to-speech (TTS) voice   | [Help](Docs/speak-italian.ps1.md)     |
| [speak-joke.ps1](Scripts/speak-joke.ps1)             | Speaks a random Chuck Norris joke by text-to-speech (TTS)          | [Help](Docs/speak-joke.ps1.md)        |
| [speak-quote.ps1](Scripts/speak-quote.ps1)           | Speaks a random quote by text-to-speech (TTS)                      | [Help](Docs/speak-quote.ps1.md)       |
| [speak-spanish.ps1](Scripts/speak-spanish.ps1)       | Speaks the given text with a Spanish text-to-speech (TTS) voice    | [Help](Docs/speak-spanish.ps1.md)     |
| [speak-test.ps1](Scripts/speak-test.ps1)             | Performs a speak test by text-to-speech (TTS)                      | [Help](Docs/speak-test.ps1.md)        |
| [speak-text.ps1](Scripts/speak-text.ps1)             | Speaks the given text by text-to-speech (TTS)                      | [Help](Docs/speak-text.ps1.md)        |
| [speak-time.ps1](Scripts/speak-time.ps1)             | Speaks the current time by text-to-speech (TTS)                    | [Help](Docs/speak-time.ps1.md)        |
| [turn-volume-up.ps1](Scripts/turn-volume-up.ps1)     | Turns the audio volume up (+10% by default)                        | [Help](Docs/turn-volume-up.ps1.md)    |
| [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) | Turns the audio volume down (-10% by default)                      | [Help](Docs/turn-volume-down.ps1.md)  |
| [unmute-audio.ps1](Scripts/unmute-audio.ps1)         | Unmutes the audio device                                           | [Help](Docs/unmute-audio.ps1.md)      |
| [voice-control.ps1](Scripts/voice-control.ps1)       | Executes the PowerShell scripts by voice                           | [Help](Docs/voice-control.ps1.md)     |

⚙️ Scripts to Manage Computers
-------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) | Adds firewall rules for the given executables (needs admin rights) | [Help](Docs/add-firewall-rules.ps1.md) |
| [check-cpu-temp.ps1](Scripts/check-cpu-temp.ps1)     | Checks the CPU temperature                                         | [Help](Docs/check-cpu-temp.ps1.md)      |
| [check-dns-resolution.ps1](Scripts/check-dns-resolution.ps1) | Checks the DNS resolution with frequently used domain names| [Help](Docs/check-dns-resolution.ps1.md)|
| [check-drive-space.ps1](Scripts/check-drive-space.ps1) | Checks a drive for free space left                               | [Help](Docs/check-drive-space.ps1.md)   |
| [check-file-system.ps1](Scripts/check-file-system.ps1) | Checks the file system of a drive (needs admin rights)           | [Help](Docs/check-file-system.ps1.md)   |
| [check-health.ps1](Scripts/check-health.ps1)         | Checks the system health                                           | [Help](Docs/check-health.ps1.md)        |
| [check-ping.ps1](Scripts/check-ping.ps1)             | Checks the ping latency to the internet                            | [Help](Docs/check-ping.ps1.md)          |
| [check-swap-space.ps1](Scripts/check-swap-space.ps1) | Checks the swap space for free space left                          | [Help](Docs/check-swap-space.ps1.md)    |
| [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) | Checks the validity of the Windows system files (needs admin rights) | [Help](Docs/check-windows-system-files.ps1.md) |
| [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) | Enables the writing of crash dumps                             | [Help](Docs/enable-crash-dumps.ps1.md)  |
| [hibernate.ps1](Scripts/hibernate.ps1)               | Enables hibernate mode for the local computer (needs admin rights) | [Help](Docs/hibernate.ps1.md)           |
| [install-github-cli.ps1](Scripts/install-github-cli.ps1) | Installs GitHub CLI                                            | [Help](Docs/install-github-cli.ps1.md)  |
| [install-google-chrome.ps1](Scripts/install-google-chrome.ps1) | Installs the Google Chrome browser                       | [Help](Docs/install-google-chrome.ps1.md)|
| [install-knot-resolver.ps1](Scripts/install-knot-resolver.ps1) | Installs the Knot Resolver (needs admin rights)          | [Help](Docs/install-knot-resolver.ps1.md)|
| [install-ssh-client.ps1](Scripts/install-ssh-client.ps1) | Installs the SSH client (needs admin rights)                   | [Help](Docs/install-ssh-client.ps1.md)  |
| [install-ssh-server.ps1](Scripts/install-ssh-server.ps1) | Installs the SSH server (needs admin rights)                   | [Help](Docs/install-ssh-server.ps1.md)  |
| [install-signal-cli.ps1](Scripts/install-signal-cli.ps1) | Installs signal-cli from github.com/AsamK/signal-cli           | [Help](Docs/install-signal-cli.ps1.md)  |
| [install-vscode.ps1](Scripts/install-vscode.ps1)     | Installs Visual Studio Code                                        | [Help](Docs/install-vscode.ps1.md)      |
| [install-wsl.ps1](Scripts/install-wsl.ps1)           | Installs Windows Subsystem for Linux (WSL), needs admin rights     | [Help](Docs/install-wsl.ps1.md)         |
| [list-cli-tools.ps1](Scripts/list-cli-tools.ps1)     | Lists available command-line interface (CLI) tools                 | [Help](Docs/list-cli-tools.ps1.md)      |
| [list-drives.ps1](Scripts/list-drives.ps1)           | Lists all drives                                                   | [Help](Docs/list-drives.ps1.md)         |
| [list-network-shares.ps1](Scripts/list-network-shares.ps1) | Lists the network shares of the local computer               | [Help](Docs/list-network-shares.ps1.md) |
| [list-installed-apps.ps1](Scripts/list-installed-apps.ps1) | Lists the installed Windows Store apps                       | [Help](Docs/list-installed-apps.ps1.md) |
| [list-installed-software.ps1](Scripts/list-installed-software.ps1) | Lists the installed software (except Windows Store apps) | [Help](Docs/list-installed-software.ps1.md)|
| [list-printers.ps1](Scripts/list-printers.ps1)       | Lists all printer known to the computer                            | [Help](Docs/list-printers.ps1.md)       |
| [list-print-jobs.ps1](Scripts/list-print-jobs.ps1) | Lists all jobs of all printers                                       | [Help](Docs/list-print-jobs.ps1.md)     |
| [list-processes.ps1](Scripts/list-processes.ps1)     | Lists the local computer processes                                 | [Help](Docs/list-processes.ps1.md)      |
| [list-services.ps1](Scripts/list-services.ps1)       | Lists the services on the local computer                           | [Help](Docs/list-services.ps1.md)       |
| [list-system-info.ps1](Scripts/list-system-info.ps1) | Lists system information on the local computer                     | [Help](Docs/list-system-info.ps1.md)    |
| [list-tasks.ps1](Scripts/list-tasks.ps1)             | Lists all Windows scheduler tasks                                  | [Help](Docs/list-tasks.ps1.md)          |
| [list-timezone.ps1](Scripts/list-timezone.ps1)       | Lists the current time zone details                                | [Help](Docs/list-timezone.ps1.md)       |
| [list-timezones.ps1](Scripts/list-timezones.ps1)     | Lists all time zones available                                     | [Help](Docs/list-timezones.ps1.md)      |
| [list-user-groups.ps1](Scripts/list-user-groups.ps1) | Lists the user groups on the local computer                        | [Help](Docs/list-user-groups.ps1.md)    |
| [poweroff.ps1](Scripts/poweroff.ps1)                 | Halts the local computer (needs admin rights)                      | [Help](Docs/poweroff.ps1.md)            |
| [query-smart-data.ps1](Scripts/query-smart-data.ps1) | Queries the S.M.A.R.T. data of your HDD/SSD's                      | [Help](Docs/query-smart-data.ps1.md)    |
| [reboot.ps1](Scripts/reboot.ps1)                     | Reboots the local computer (needs admin rights)                    | [Help](Docs/reboot.ps1.md)              |
| [remove-print-jobs.ps1](Scripts/remove-print-jobs.ps1) | Removes all jobs from all printers                               | [Help](Docs/remove-print-jobs.ps1.md)   |
| [restart-network-adapters.ps1](Scripts/restart-network-adapters.ps1) | Restarts all local network adapters                | [Help](Docs/restart-network-adapters.ps1.md)|
| [upgrade-ubuntu.ps1](Scripts/upgrade-ubuntu.ps1)     | Upgrades Ubuntu Linux to the latest (LTS) release                  | [Help](Docs/upgrade-ubuntu.ps1.md)      |
| [wakeup.ps1](Scripts/wakeup.ps1)                     | Sends a magic packet to a computer to wake him up                  | [Help](Docs/wakeup.ps1.md)              |

💻 Scripts for the Desktop
---------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [close-calculator.ps1](Scripts/close-calculator.ps1) | Closes the calculator program gracefully                           | [Help](Docs/close-calculator.ps1.md)    |
| [close-chrome.ps1](Scripts/close-chrome.ps1)         | Closes Google Chrome gracefully                                    | [Help](Docs/close-chrome.ps1.md)        |
| [close-cortana.ps1](Scripts/close-cortana.ps1)       | Closes Cortana gracefully                                          | [Help](Docs/close-cortana.ps1.md)       |
| [close-edge.ps1](Scripts/close-edge.ps1)             | Closes Microsoft Edge gracefully                                   | [Help](Docs/close-edge.ps1.md)          |
| [close-file-explorer.ps1](Scripts/close-file-explorer.ps1) | Closes Microsoft File Explorer gracefully                    | [Help](Docs/close-file-explorer.ps1.md) |
| [close-firefox.ps1](Scripts/close-firefox.ps1)       | Closes the Firefox Web browser gracefully                          | [Help](Docs/close-firefox.ps1.md)       |
| [close-program.ps1](Scripts/close-program.ps1)       | Closes the given program gracefully                                | [Help](Docs/close-program.ps1.md)       |
| [close-netflix.ps1](Scripts/close-netflix.ps1)       | Closes Netflix gracefully                                          | [Help](Docs/close-netflix.ps1.md)       |
| [close-onedrive.ps1](Scripts/close-onedrive.ps1)     | Closes Microsoft OneDrive gracefully                               | [Help](Docs/close-onedrive.ps1.md)      |
| [close-system-settings.ps1](Scripts/close-system-settings.ps1) | Closes the System Settings gracefully                    | [Help](Docs/close-system-settings.ps1.md)|
| [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) | Closes Mozilla Thunderbird gracefully                            | [Help](Docs/close-thunderbird.ps1.md)   |
| [close-vlc.ps1](Scripts/close-vlc.ps1)               | Closes the VLC media player gracefully                             | [Help](Docs/close-vlc.ps1.md)           |
| [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) | Closes Windows Terminal gracefully                     | [Help](Docs/close-windows-terminal.ps1.md)|
| [enable-god-mode.ps1](Scripts/enable-god-mode.ps1)   | Enables the god mode (adds a new icon to the desktop)              | [Help](Docs/enable-god-mode.ps1.md)     |
| [list-clipboard.ps1](Scripts/list-clipboard.ps1)     | Lists the contents of the clipboard                                | [Help](Docs/list-clipboard.ps1.md)      |
| [new-email.ps1](Scripts/new-email.ps1)               | Starts the default email client to write a new email               | [Help](Docs/new-email.ps1.md)           |
| [open-browser.ps1](Scripts/open-browser.ps1)         | Starts the default Web browser                                     | [Help](Docs/open-browser.ps1.md)        |
| [open-calculator.ps1](Scripts/open-calculator.ps1)   | Starts the calculator program                                      | [Help](Docs/open-calculator.ps1.md)     |
| [open-email-client.ps1](Scripts/open-browser.ps1)    | Starts the default email client                                    | [Help](Docs/open-email-client.ps1.md)   |
| [open-file-explorer.ps1](Scripts/open-file-explorer.ps1) | Starts the File Explorer                                       | [Help](Docs/open-file-explorer.ps1.md)  |
| [open-netflix.ps1](Scripts/open-netflix.ps1)         | Starts the Netflix app                                             | [Help](Docs/open-netflix.ps1.md)        |
| [open-onedrive.ps1](Scripts/open-onedrive.ps1)       | Opens the user's OneDrive folder                                   | [Help](Docs/open-onedrive.ps1.md)       |
| [open-recycle-bin.ps1](Scripts/open-recycle-bin.ps1) | Starts the File Explorer with the recycle bin folder               | [Help](Docs/open-recycle-bin.ps1.md)    |
| [set-wallpaper.ps1](Scripts/set-wallpaper.ps1)       | Sets the given image as wallpaper                                  | [Help](Docs/set-wallpaper.ps1.md)       |
| [take-screenshot.ps1](Scripts/take-screenshot.ps1)   | Takes a single screenshot                                          | [Help](Docs/take-screenshot.ps1.md)     |
| [take-screenshots.ps1](Scripts/take-screenshots.ps1) | Takes multiple screenshots (every minute by default)               | [Help](Docs/take-screenshots.ps1.md)    |

📁 Scripts for Files & Folders 
-------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [cd-desktop.ps1](Scripts/cd-desktop.ps1)             | Go to the user's desktop folder                                    | [Help](Docs/cd-desktop.ps1.md)          |
| [cd-docs.ps1](Scripts/cd-docs.ps1)                   | Go to the user's documents folder                                  | [Help](Docs/cd-docs.ps1.md)             |
| [cd-downloads.ps1](Scripts/cd-downloads.ps1)         | Go to the user's downloads folder                                  | [Help](Docs/cd-downloads.ps1.md)        |
| [cd-dropbox.ps1](Scripts/cd-dropbox.ps1)             | Go to the user's Dropbox folder                                    | [Help](Docs/cd-dropbox.ps1.md)          |
| [cd-home.ps1](Scripts/cd-home.ps1)                   | Go to the user's home folder                                       | [Help](Docs/cd-home.ps1.md)             |
| [cd-music.ps1](Scripts/cd-music.ps1)                 | Go to the user's music folder                                      | [Help](Docs/cd-music.ps1.md)            |  
| [cd-onedrive.ps1](Scripts/cd-onedrive.ps1)           | Go to the user's OneDrive folder                                   | [Help](Docs/cd-onedrive.ps1.md)         |
| [cd-pics.ps1](Scripts/cd-pics.ps1)                   | Go to the user's pictures folder                                   | [Help](Docs/cd-pics.ps1.md)             |
| [cd-recycle-bin.ps1](Scripts/cd-recycle-bin.ps1)     | Go to the user's recycle bin folder                                | [Help](Docs/cd-recycle-bin.ps1.md)      |
| [cd-repos.ps1](Scripts/cd-repos.ps1)                 | Go to the user's Git repositories folder                           | [Help](Docs/cd-repos.ps1.md)            |
| [cd-root.ps1](Scripts/cd-root.ps1)                   | Go to the root directory (C:\ on Windows)                          | [Help](Docs/cd-root.ps1.md)             |
| [cd-scripts.ps1](Scripts/cd-scripts.ps1)             | Go to the PowerShell Scripts folder                                | [Help](Docs/cd-scripts.ps1.md)          |
| [cd-up.ps1](Scripts/cd-up.ps1)                       | Go one directory level up                                          | [Help](Docs/cd-up.ps1.md)               | 
| [cd-up2.ps1](Scripts/cd-up2.ps1)                     | Go two directory levels up                                         | [Help](Docs/cd-up2.ps1.md)              |
| [cd-up3.ps1](Scripts/cd-up3.ps1)                     | Go three directory levels up                                       | [Help](Docs/cd-up3.ps1.md)              |
| [cd-up4.ps1](Scripts/cd-up4.ps1)                     | Go four directory levels up                                        | [Help](Docs/cd-up4.ps1.md)              |
| [cd-videos.ps1](Scripts/cd-videos.ps1)               | Go to the user's videos folder                                     | [Help](Docs/cd-videos.ps1.md)           |
| [check-symlinks.ps1](Scripts/check-symlinks.ps1)     | Checks every symlink in the given directory tree                   | [Help](Docs/check-symlinks.ps1.md)      |
| [check-xml-file.ps1](Scripts/check-xml-file.ps1)     | Checks the given XML file for validity                             | [Help](Docs/check-xml-file.ps1.md)      |
| [clear-recycle-bin.ps1](Scripts/clear-recycle-bin.ps1) | Removes the content of the recycle bin folder (can not be undo!) | [Help](Docs/clear-recycle-bin.ps1.md)   |
| [copy-photos-sorted.ps1](Scripts/copy-photos-sorted.ps1) | Copies all photos sorted by year and month                     | [Help](Docs/copy-photos-sorted.ps1.md)  |
| [decrypt-file.ps1](Scripts/decrypt-file.ps1)         | Encrypts the given file                                            | [Help](Docs/decrypt-files.ps1.md)       |
| [download-dir.ps1](Scripts/download-dir.ps1)         | Downloads a directory tree from the given URL                      | [Help](Docs/download-dir.ps1.md)        |
| [download-file.ps1](Scripts/download-file.ps1)       | Downloads a file from the given URL                                | [Help](Docs/download-file.ps1.md)       |
| [edit.ps1](Scripts/edit.ps1)                         | Edits the given file with the built-in text editor                 | [Help](Docs/edit.ps1.md)                |
| [encrypt-file.ps1](Scripts/encrypt-file.ps1)         | Encrypts the given file                                            | [Help](Docs/encrypt-file.ps1.md)        |
| [get-md5.ps1](Scripts/get-md5.ps1)                   | Prints the MD5 checksum of the given file                          | [Help](Docs/get-md5.ps1.md)             |
| [get-sha1.ps1](Scripts/get-sha1.ps1)                 | Prints the SHA1 checksum of the given file                         | [Help](Docs/get-sha1.ps1.md)            |
| [get-sha256.ps1](Scripts/get-sha256.ps1)             | Prints the SHA256 checksum of the given file                       | [Help](Docs/get-sha256.ps1.md)          |
| [inspect-exe.ps1](Scripts/inspect-exe.ps1)           | Prints basic information of the given executable file              | [Help](Docs/inspect-exe.ps1.md)         |
| [list-dir.ps1](Scripts/list-dir.ps1)                 | Lists the directory content (formatted in columns)                 | [Help](Docs/list-dir.ps1.md)            |
| [list-dir-tree.ps1](Scripts/list-dir-tree.ps1)       | Lists the directory tree content                                   | [Help](Docs/list-dir-treep.ps1.md)      |
| [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1)   | Lists empty subfolders within the given directory tree             | [Help](Docs/list-empty-dirs.ps1.md)     |
| [list-empty-files.ps1](Scripts/list-empty-files.ps1) | Lists empty files within the given directory tree                  | [Help](Docs/list-empty-files.ps1.md)    |
| [list-files.ps1](Scripts/list-files.ps1)             | Lists all files in the given folder and also in every subfolder    | [Help](Docs/list-files.ps1.md)          |
| [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) | Lists hidden files within the given directory tree               | [Help](Docs/list-hidden-files.ps1.md)   |
| [list-recycle-bin.ps1](Scripts/list-recycle-bin.ps1) | Lists the content of the recycle bin folder                        | [Help](Docs/list-recycle-bin.ps1.md)    |
| [list-unused-files.ps1](Scripts/list-unused-files.ps1) | Lists unused files in a directory tree                           | [Help](Docs/list-unused-files.ps1.md)   |
| [list-workdir.ps1](Scripts/list-workdir.ps1)         | Lists the current working directory                                | [Help](Docs/list-workdir.ps1.md)        |
| [make-install.ps1](Scripts/make-install.ps1)         | Installs built executables and libs to the installation directory  | [Help](Docs/make-install.ps1.md)        |
| [new-shortcut.ps1](Scripts/new-shortcut.ps1)         | Creates a new shortcut                                             | [Help](Docs/new-shortcut.ps1.md)        |
| [new-symlink.ps1](Scripts/new-symlink.ps1)           | Creates a new symbolic link                                        | [Help](Docs/new-symlink.ps1.md)         |
| [new-zipfile.ps1](Scripts/new-zipfile.ps1)           | Creates a new .zip file from a directory                           | [Help](Docs/new-zipfile.ps1.md)         |
| [publish-to-ipfs.ps1](Scripts/publish-to-ipfs.ps1)   | Publishes the given files or directory to IPFS                     | [Help](Docs/publish-to-ipfs.ps1.md)     |
| [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) | Removes empty subfolders within the given directory tree         | [Help](Docs/remove-empty-dirs.ps1.md)   |
| [search-filename.ps1](Scripts/search-filename.ps1)   | Searches the directory tree for filenames by given pattern         | [Help](Docs/search-filename.ps1.md)     |
| [search-files.ps1](Scripts/search-files.ps1)         | Searches the given pattern in the given files                      | [Help](Docs/search-files.ps1.md)        |
| [upload-file.ps1](Scripts/upload-file.ps1)           | Uploads the local file to the given FTP server                     | [Help](Docs/upload-file.ps1.md)         |

♻️ Scripts to Convert Files
---------------------------

| Script                                                 | Description                                                        | Help                                  |
| ------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------- |
| [convert-csv2txt.ps1](Scripts/convert-csv2txt.ps1)     | Converts a given .CSV file to a text file                          | [Help](Docs/convert-csv2txt.ps1.md)   |
| [convert-mysql2csv.ps1](Scripts/convert-mysql2csv.ps1) | Converts a MySQL database table to a .CSV file                     | [Help](Docs/convert-mysql2csv.ps1.md) |
| [convert-ps2bat.ps1](Scripts/convert-ps2bat.ps1)       | Converts a PowerShell script to a .BAT file                        | [Help](Docs/convert-ps2bat.ps1.md)    |
| [convert-ps2md.ps1](Scripts/convert-ps2md.ps1)         | Converts the comment-based help of a PowerShell script to Markdown | [Help](Docs/convert-ps2md.ps1.md)     |
| [convert-sql2csv.ps1](Scripts/convert-sql2csv.ps1)     | Converts a SQL database table to a .CSV file                       | [Help](Docs/convert-sql2csv.ps1.md)   |
| [convert-txt2wav.ps1](Scripts/convert-txt2wav.ps1)     | Converts text to a .WAV audio file                                 | [Help](Docs/convert-txt2wav.ps1.md)   |

📝 Scripts for Git
-------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [cherry-picker.ps1](Scripts/cherry-picker.ps1)       | Cherry-picks a Git commit into multiple branches                   | [Help](Docs/cherry-picker.ps1.md)       |
| [clean-repo.ps1](Scripts/clean-repo.ps1)             | Cleans a Git repository from untracked files (including submodules) | [Help](Docs/clean-repo.ps1.md)         |
| [clean-repos.ps1](Scripts/clean-repos.ps1)           | Cleans all Git repositories under a directory from untracked files (including submodules) | [Help](Docs/clean-repos.ps1.md)   |
| [clone-repos.ps1](Scripts/clone-repos.ps1)           | Clones well-known Git repositories                                 | [Help](Docs/clone-repos.ps1.md)         |
| [configure-git.ps1](Scripts/configure-git.ps1)       | Sets up the Git user configuration                                 | [Help](Docs/configure-git.ps1.md)       |
| [fetch-repo.ps1](Scripts/fetch-repo.ps1)             | Fetches updates for a Git repository (including submodules)        | [Help](Docs/fetch-repo.ps1.md)          |
| [fetch-repos.ps1](Scripts/fetch-repos.ps1)           | Fetches updates for all Git repositories under a directory (including submodules) | [Help](Docs/fetch-repos.ps1.md)|
| [list-branches.ps1](Scripts/list-branches.ps1)       | Lists all branches in a Git repository                             | [Help](Docs/list-branches.ps1.md)       |
| [list-commits.ps1](Scripts/list-commits.ps1)         | Lists all commits in a Git repository                              | [Help](Docs/list-commits.ps1.md)        |
| [list-latest-tag.ps1](Scripts/list-latest-tag.ps1)   | Lists the latest tag on the current branch in a Git repository     | [Help](Docs/list-latest-tag.ps1.md)     |
| [list-latest-tags.ps1](Scripts/list-latest-tags.ps1) | Lists the latests tags in all Git repositories under a directory   | [Help](Docs/list-latest-tags.ps1.md)    |
| [list-submodules.ps1](Scripts/list-submodules.ps1)   | Lists the submodules in a Git repository                           | [Help](Docs/list-submodules.ps1.md)     |
| [list-tags.ps1](Scripts/list-tags.ps1)               | Lists all tags in a Git repository                                 | [Help](Docs/list-tags.ps1.md)           |
| [make-repo.ps1](Scripts/make-repo.ps1)               | Builds a Git repository                                            | [Help](Docs/make-repo.ps1.md)           |
| [make-repos.ps1](Scripts/make-repos.ps1)             | Builds all Git repositories under a directory                      | [Help](Docs/make-repos.ps1.md)          |
| [new-branch.ps1](Scripts/new-branch.ps1)             | Creates a new branch in a Git repository                           | [Help](Docs/new-branch.ps1.md)          |
| [new-tag.ps1](Scripts/new-tag.ps1)                   | Creates a new tag in a Git repository                              | [Help](Docs/new-tag.ps1.md)             |
| [pull-repo.ps1](Scripts/pull-repo.ps1)               | Pulls updates for a Git repository (including submodules)          | [Help](Docs/pull-repo.ps1.md)           |
| [pull-repos.ps1](Scripts/pull-repos.ps1)             | Pulls updates for all Git repositories under a directory (including submodules) | [Help](Docs/pull-repos.ps1.md)|
| [remove-tag.ps1](Scripts/remove-tag.ps1)             | Removes a tag in a Git repository                                  | [Help](Docs/remove-tag.ps1.md)       |
| [switch-branch.ps1](Scripts/switch-branch.ps1)       | Switches the branch in a Git repository (including submodules)     | [Help](Docs/switch-branch.ps1.md)       |
| [sync-repo.ps1](Scripts/sync-repo.ps1)               | Synchronizes a Git repository by push & pull (including submodules) | [Help](Docs/sync-repo.ps1.md)          |

🔎 Scripts for PowerShell 
------------------------

| Script                                                 | Description                                                        | Help                                    |
| ------------------------------------------------------ | ------------------------------------------------------------------ | --------------------------------------- |
| [daily-tasks.sh](Scripts/daily-tasks.sh)               | Execute PowerShell scripts automatically as daily tasks (Linux only) | [Help](Docs/daily-tasks.sh.md)        |
| [introduce-powershell.ps1](Scripts/introduce-powershell.ps1) | Introduces PowerShell to new users                           | [Help](Docs/introduce-powershell.ps1.md)|
| [list-aliases.ps1](Scripts/list-aliases.ps1)           | Lists all PowerShell aliases                                       | [Help](Docs/list-aliases.ps1.md)        |
| [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) | Lists the automatic variables of PowerShell          | [Help](Docs/list-automatic-variables.ps1.md)|
| [list-cheat-sheet.ps1](Scripts/list-cheat-sheet.ps1)   | Lists the PowerShell cheat sheet                                   | [Help](Docs/list-cheat-sheet.ps1.md)    |
| [list-cmdlets.ps1](Scripts/list-cmdlets.ps1)           | Lists the PowerShell cmdlets                                       | [Help](Docs/list-cmdlets.ps1.md)        |
| [list-console-colors.ps1](Scripts/list-console-colors.ps1) | Lists all console colors                                       | [Help](Docs/list-console-colors.ps1.md) |
| [list-modules.ps1](Scripts/list-modules.ps1)           | Lists the PowerShell modules                                       | [Help](Docs/list-modules.ps1.md)        |
| [list-profiles.ps1](Scripts/list-profiles.ps1)         | Lists your PowerShell profiles                                     | [Help](Docs/list-profiles.ps1.md)       |
| [list-scripts.ps1](Scripts/list-scripts.ps1)           | Lists all PowerShell scripts in this repository                    | [Help](Docs/list-scripts.ps1.md)        |
| [new-script.ps1](Scripts/new-script.ps1)               | Creates a new PowerShell script                                    | [Help](Docs/new-script.ps1.md)          |
| [set-profile.ps1](Scripts/set-profile.ps1)             | Updates your PowerShell user profile                               | [Help](Docs/set-profile.ps1.md)         |

🛒 Various PowerShell Scripts 
------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [add-memo.ps1](Scripts/add-memo.ps1)                 | Adds the given memo text to $HOME/Memos.csv                        | [Help](Docs/wakeup.ps1.md)              |
| [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1)| Checks the given IPv4 address for validity                      | [Help](Docs/wakeup.ps1.md)              |
| [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1)| Checks the given IPv6 address for validity                      | [Help](Docs/wakeup.ps1.md)              |
| [check-mac-address.ps1](Scripts/check-mac-address.ps1)| Checks the given MAC address for validity                         | [Help](Docs/wakeup.ps1.md)              |
| [check-subnet-mask.ps1](Scripts/check-subnet-mask.ps1)| Checks the given subnet mask for validity                         | [Help](Docs/wakeup.ps1.md)              |
| [check-weather.ps1](Scripts/check-weather.ps1)       | Checks the current weather for critical values                     | [Help](Docs/wakeup.ps1.md)              |
| [display-time.ps1](Scripts/display-time.ps1)         | Displays the current time for 10 seconds by default                | [Help](Docs/wakeup.ps1.md)              |
| [list-anagrams.ps1](Scripts/list-anagrams.ps1)       | Lists all anagrams of the given word                               | [Help](Docs/wakeup.ps1.md)              |
| [list-city-weather.ps1](Scripts/list-city-weather.ps1)| Lists the current weather of cities worldwide (west to east)      | [Help](Docs/wakeup.ps1.md)              |
| [list-countries.ps1](Scripts/list-countries.ps1)     | Lists details of all countries                                     | [Help](Docs/wakeup.ps1.md)              |
| [list-credits.ps1](Scripts/list-credits.ps1)         | Shows the credits                                                  | [Help](Docs/wakeup.ps1.md)              |
| [list-crypto-rates.ps1](Scripts/list-crypto-rates.ps1)| Lists the current crypto exchange rates                           | [Help](Docs/wakeup.ps1.md)              |
| [list-environment-variables.ps1](Scripts/list-environment-variables.ps1)| Lists all environment variables                 | [Help](Docs/wakeup.ps1.md)              |
| [list-emojis.ps1](Scripts/list-emojis.ps1)           | Lists the emojis of Unicode 13.0                                   | [Help](Docs/wakeup.ps1.md)              |
| [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1)| Lists the FRITZ!Box calls                                     | [Help](Docs/wakeup.ps1.md)              |
| [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1)| Lists FRITZ!Box's known devices                           | [Help](Docs/wakeup.ps1.md)              |
| [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) | Lists earthquakes with magnitude >= 6.0 for the last 30 days       | [Help](Docs/wakeup.ps1.md)              |
| [list-exchange-rates.ps1](Scripts/list-exchange-rates.ps1)| Lists the current exchange rates for the given currency       | [Help](Docs/wakeup.ps1.md)              |
| [list-memos.ps1](Scripts/list-memos.ps1)             | Lists the memos at $HOME/Memos.csv                                 | [Help](Docs/wakeup.ps1.md)              |
| [list-mysql-tables.ps1](Scripts/list-mysql-tables.ps1)| Lists the MySQL server tables                                     | [Help](Docs/wakeup.ps1.md)              |
| [list-news.ps1](Scripts/list-news.ps1)               | Lists the latest news                                              | [Help](Docs/wakeup.ps1.md)              |
| [list-os-releases.ps1](Scripts/list-os-releases.ps1) | Lists operating system releases and download URL                   | [Help](Docs/wakeup.ps1.md)              |
| [list-os-updates.ps1](Scripts/list-os-updates.ps1)   | Lists operating system updates                                     | [Help](Docs/wakeup.ps1.md)              |
| [list-passwords.ps1](Scripts/list-passwords.ps1)     | Prints a list of random passwords                                  | [Help](Docs/wakeup.ps1.md)              |
| [list-pins.ps1](Scripts/list-pins.ps1)               | Prints a list of random PIN's                                      | [Help](Docs/wakeup.ps1.md)              |
| [list-sql-tables.ps1](Scripts/list-sql-tables.ps1)   | Lists the SQL server tables                                        | [Help](Docs/wakeup.ps1.md)              |
| [list-tiobe-index.ps1](Scripts/list-tiobe-index.ps1) | Lists the TIOBE index of top programming languages                 | [Help](Docs/wakeup.ps1.md)              |
| [list-weather.ps1](Scripts/list-weather.ps1)         | Lists the hourly weather                                           | [Help](Docs/wakeup.ps1.md)              |
| [locate-city.ps1](Scripts/locate-city.ps1)           | Prints the geographic location of the given city                   | [Help](Docs/wakeup.ps1.md)              |
| [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) | Prints the geographic location of the given IP address             | [Help](Docs/wakeup.ps1.md)              |
| [locate-zip-code.ps1](Scripts/locate-zip-code.ps1)   | Prints the geographic location of the given zip-code               | [Help](Docs/wakeup.ps1.md)              |
| [moon.ps1](Scripts/moon.ps1)                         | Prints the current moon phase                                      | [Help](Docs/wakeup.ps1.md)              |
| [new-qrcode.ps1](Scripts/new-qrcode.ps1)             | Generates a new QR code image file                                 | [Help](Docs/new-qrcode.ps1.md)              |
| [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1)   | Reboots the FRITZ!box device                                       | [Help](Docs/wakeup.ps1.md)              |
| [scan-ports.ps1](Scripts/scan-ports.ps1)             | Scans the network for open/closed ports                            | [Help](Docs/wakeup.ps1.md)              |
| [send-email.ps1](Scripts/send-email.ps1)             | Sends an email message                                             | [Help](Docs/wakeup.ps1.md)              |
| [send-tcp.ps1](Scripts/send-udp.ps1)                 | Sends a TCP message to the given IP address and port               | [Help](Docs/wakeup.ps1.md)              |
| [send-udp.ps1](Scripts/send-udp.ps1)                 | Sends a UDP datagram message to the given IP address and port      | [Help](Docs/wakeup.ps1.md)              |
| [set-timer.ps1](Scripts/set-timer.ps1)               | Sets a timer for a countdown                                       | [Help](Docs/wakeup.ps1.md)              |
| [simulate-matrix.ps1](Scripts/simulate-matrix.ps1)   | Simulates the Matrix (fun)                                         | [Help](Docs/wakeup.ps1.md)              |
| [simulate-presence.ps1](Scripts/simulate-presence.ps1)| Simulates the human presence against burglars                     | [Help](Docs/wakeup.ps1.md)              |
| [start-calibre-server.ps1](Scripts/start-calibre-server.ps1)| Starts a local Calibre server                               | [Help](Docs/wakeup.ps1.md)              |
| [start-ipfs-server.ps1](Scripts/start-ipfs-server.ps1)| Starts a local IPFS server                                        | [Help](Docs/wakeup.ps1.md)              |
| [switch-shelly1.ps1](Scripts/switch-shelly1.ps1)     | Switches a Shelly1 device in the local network                     | [Help](Docs/wakeup.ps1.md)              |
| [translate-file.ps1](Scripts/translate-file.ps1)     | Translates the given text file into other languages                | [Help](Docs/wakeup.ps1.md)              |
| [translate-files.ps1](Scripts/translate-files.ps1)   | Translates the given text files into any supported language        | [Help](Docs/wakeup.ps1.md)              |
| [translate-text.ps1](Scripts/translate-text.ps1)     | Translates the given text in English into other languages          | [Help](Docs/wakeup.ps1.md)              |
| [weather.ps1](Scripts/weather.ps1)                   | Prints the current weather forecast                                | [Help](Docs/wakeup.ps1.md)              |
| [weather-report.ps1](Scripts/weather-report.ps1)     | Prints the local weather report                                    | [Help](Docs/wakeup.ps1.md)              |
| [what-is.ps1](Scripts/what-is.ps1)                   | Prints a description of the given abbreviation                     | [Help](Docs/wakeup.ps1.md)              |
| [write-animated.ps1](Scripts/write-animated.ps1)     | Writes animated text                                               | [Help](Docs/wakeup.ps1.md)              |
| [write-big.ps1](Scripts/write-big.ps1)               | Writes the given text in big letters                               | [Help](Docs/wakeup.ps1.md)              |
| [write-blue.ps1](Scripts/write-blue.ps1)             | Writes the given text in a blue foreground color                   | [Help](Docs/wakeup.ps1.md)              |
| [write-braille.ps1](Scripts/write-braille.ps1)       | Writes the given text in Braille                                   | [Help](Docs/wakeup.ps1.md)              |
| [write-green.ps1](Scripts/write-green.ps1)           | Writes the given text in a green foreground color                  | [Help](Docs/wakeup.ps1.md)              |
| [write-joke.ps1](Scripts/write-joke.ps1)             | Writes a random Juck Norris joke                                   | [Help](Docs/wakeup.ps1.md)              |
| [write-lowercase.ps1](Scripts/write-lowercase.ps1)   | Writes the given text in lowercase letters                         | [Help](Docs/wakeup.ps1.md)              |
| [write-marquee.ps1](Scripts/write-marquee.ps1)       | Writes the given text as marquee                                   | [Help](Docs/wakeup.ps1.md)              |
| [write-morse-code.ps1](Scripts/write-morse-code.ps1) | Writes the given text in Morse code                                | [Help](Docs/wakeup.ps1.md)              |
| [write-motd.ps1](Scripts/write-motd.ps1)             | Writes the message of the day (MOTD)                               | [Help](Docs/wakeup.ps1.md)              |
| [write-quote.ps1](Scripts/write-quote.ps1)           | Writes a random quote                                              | [Help](Docs/wakeup.ps1.md)              |
| [write-red.ps1](Scripts/write-red.ps1)               | Writes the given text in a red foreground color                    | [Help](Docs/wakeup.ps1.md)              |
| [write-rot13.ps1](Scripts/write-rot13.ps1)           | Encodes or decodes the given text with ROT13                       | [Help](Docs/wakeup.ps1.md)              |
| [write-typewriter.ps1](Scripts/write-typewriter.ps1) | Writes the given text with the typewriter effect                   | [Help](Docs/wakeup.ps1.md)              |
| [write-uppercase.ps1](Scripts/write-uppercase.ps1)   | Writes the given text in uppercase letters                         | [Help](Docs/wakeup.ps1.md)              |
| [write-vertical.ps1](Scripts/write-vertical.ps1)     | Writes the given text in vertical direction                        | [Help](Docs/wakeup.ps1.md)              |

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License & Copyright
-------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
