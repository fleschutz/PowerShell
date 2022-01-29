Mega Collection of PowerShell Scripts
=====================================

**This repository provides more than 250 useful and cross-platform PowerShell scripts in the [📂Scripts](Scripts/) subfolder - to be used by command-line interface (CLI), for remote control (e.g. via SSH), by context menu, by voice control (see also the [talk2windows](https://github.com/fleschutz/talk2windows) repository), by automation software like [Jenkins](https://www.jenkins.io/), automatically as daily tasks, or simply to learn PowerShell. See the [FAQ page](Docs/FAQ.md) if you need help or have any questions.**

**Note:** the scripts fully support Unicode characters. It's recommended to use a modern console supporting UTF-8 (e.g. Windows Terminal).

🔊 Scripts for Audio & Voice 
-----------------------------

| Script                                               | Description                                                        | Help                                |
| ---------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------- |
| [list-voices.ps1](Scripts/list-voices.ps1)           | Lists the installed text-to-speech voices                          | [Help](Docs/list-voices.md)         |
| [play-beep-sound.ps1](Scripts/play-beep-sound.ps1)   | Plays a short beep sound                                           | [Help](Docs/play-beep-sound.md)     |
| [play-files.ps1](Scripts/play-files.ps1)             | Plays the given audio files                                        | [Help](Docs/play-files.md)          |
| [play-happy-birthday.ps1](Scripts/play-happy-birthday.ps1) | Plays the Happy Birthday song                                | [Help](Docs/play-happy-birthday.md) |
| [play-imperial-march.ps1](Scripts/play-imperial-march.ps1) | Plays the Imperial March (Star Wars)                         | [Help](Docs/play-imperial-march.md) |
| [play-jingle-bells.ps1](Scripts/play-jingle-bells.ps1) | Plays Jingle Bells                                               | [Help](Docs/play-jingle-bells.md)   |
| [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) | Plays the Mission Impossible theme                   | [Help](Docs/play-mission-impossible.md)|
| [play-m3u.ps1](Scripts/play-m3u.ps1)                 | Plays the given playlist (M3U file format)                         | [Help](Docs/play-m3u.md)            |
| [play-mp3.ps1](Scripts/play-mp3.ps1)                 | Plays the given sound file (MP3 file format)                       | [Help](Docs/play-mp3.md)            |
| [play-super-mario.ps1](Scripts/play-super-mario.ps1) | Plays the Super Mario intro                                        | [Help](Docs/play-super-mario.md)    |
| [play-tetris-melody.ps1](Scripts/play-tetris-melody.ps1) | Plays the Tetris melody                                        | [Help](Docs/play-tetris-melody.md)  |
| [speak-checklist.ps1](Scripts/speak-checklist.ps1)   | Speaks the given checklist by text-to-speech                       | [Help](Docs/speak-checklist.md)     |
| [speak-countdown.ps1](Scripts/speak-countdown.ps1)   | Starts a countdown by text-to-speech                               | [Help](Docs/speak-countdown.md)     |
| [speak-english.ps1](Scripts/speak-english.ps1)       | Speaks the given text with an English text-to-speech voice         | [Help](Docs/speak-english.md)       |
| [speak-epub.ps1](Scripts/speak-epub.ps1)             | Speaks the content of the given Epub file by text-to-speech        | [Help](Docs/speak-epub.md)          |
| [speak-file.ps1](Scripts/speak-file.ps1)             | Speaks the content of the given text file by text-to-speech        | [Help](Docs/speak-file.md)          |
| [speak-french.ps1](Scripts/speak-french.ps1)         | Speaks the given text with a French text-to-speech voice           | [Help](Docs/speak-french.md)        |
| [speak-german.ps1](Scripts/speak-german.ps1)         | Speaks the given text with a German text-to-speech voice           | [Help](Docs/speak-german.md)        |
| [speak-italian.ps1](Scripts/speak-italian.ps1)       | Speaks the given text with an Italian text-to-speech voice         | [Help](Docs/speak-italian.md)       |
| [speak-spanish.ps1](Scripts/speak-spanish.ps1)       | Speaks the given text with a Spanish text-to-speech voice          | [Help](Docs/speak-spanish.md)       |
| [speak-test.ps1](Scripts/speak-test.ps1)             | Performs a speak test by text-to-speech                            | [Help](Docs/speak-test.md)          |
| [speak-text.ps1](Scripts/speak-text.ps1)             | Speaks the given text by text-to-speech                            | [Help](Docs/speak-text.md)          |
| [tell-joke.ps1](Scripts/tell-joke.ps1)               | Tell a joke by text-to-speech                                      | [Help](Docs/tell-joke.md)           |
| [tell-quote.ps1](Scripts/tell-quote.ps1)             | Tell a quote by text-to-speech                                     | [Help](Docs/tell-quote.md)          |
| [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) | Turns the audio volume down                                        | [Help](Docs/turn-volume-down.md)    |
| [turn-volume-off.ps1](Scripts/turn-volume-off.ps1)   | Turn audio off                                                     | [Help](Docs/turn-volume-off-audio.md)|
| [turn-volume-on.ps1](Scripts/turn-volume-on.ps1)     | Turn audio on                                                      | [Help](Docs/turn-volume-on.md)      |
| [turn-volume-up.ps1](Scripts/turn-volume-up.ps1)     | Turns the audio volume up                                          | [Help](Docs/turn-volume-up.md)      |


⚙️ Scripts to Manage Computers
-------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) | Adds firewall rules for the given executables (needs admin rights) | [Help](Docs/add-firewall-rules.md)  |
| [check-cpu.ps1](Scripts/check-cpu.ps1)| Checks the CPU temperature                                                        | [Help](Docs/check-cpu.md)               |
| [check-dns.ps1](Scripts/check-dns.ps1) | Checks the DNS resolution                                                        | [Help](Docs/check-dns.md)               |
| [check-drive-space.ps1](Scripts/check-drive-space.ps1) | Checks a drive for free space left                               | [Help](Docs/check-drive-space.md)   |
| [check-file-system.ps1](Scripts/check-file-system.ps1) | Checks the file system of a drive (needs admin rights)           | [Help](Docs/check-file-system.md)   |
| [check-health.ps1](Scripts/check-health.ps1)         | Checks the system health                                           | [Help](Docs/check-health.md)        |
| [check-ping.ps1](Scripts/check-ping.ps1)             | Checks the ping latency to the internet                            | [Help](Docs/check-ping.md)          |
| [check-swap-space.ps1](Scripts/check-swap-space.ps1) | Checks the swap space for free space left                          | [Help](Docs/check-swap-space.md)    |
| [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) | Checks the validity of the Windows system files (needs admin rights) | [Help](Docs/check-windows-system-files.md) |
| [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) | Enables the writing of crash dumps                             | [Help](Docs/enable-crash-dumps.md)  |
| [hibernate.ps1](Scripts/hibernate.ps1)               | Enables hibernate mode for the local computer (needs admin rights) | [Help](Docs/hibernate.md)           |
| [install-github-cli.ps1](Scripts/install-github-cli.ps1) | Installs GitHub CLI                                            | [Help](Docs/install-github-cli.md)  |
| [install-chrome-browser.ps1](Scripts/install-chrome-browser.ps1) | Installs the Google Chrome browser                       | [Help](Docs/install-chrome-browser.md)|
| [install-knot-resolver.ps1](Scripts/install-knot-resolver.ps1) | Installs the Knot Resolver (needs admin rights)          | [Help](Docs/install-knot-resolver.md)|
| [install-ssh-client.ps1](Scripts/install-ssh-client.ps1) | Installs the SSH client (needs admin rights)                   | [Help](Docs/install-ssh-client.md)  |
| [install-ssh-server.ps1](Scripts/install-ssh-server.ps1) | Installs the SSH server (needs admin rights)                   | [Help](Docs/install-ssh-server.md)  |
| [install-signal-cli.ps1](Scripts/install-signal-cli.ps1) | Installs signal-cli from github.com/AsamK/signal-cli           | [Help](Docs/install-signal-cli.md)  |
| [install-updates.ps1](Scripts/install-updates.ps1)   | Installs updates (need admin rights)                               | [Help](Docs/install-updates.md)      |
| [install-wsl.ps1](Scripts/install-wsl.ps1)           | Installs Windows Subsystem for Linux (WSL), needs admin rights     | [Help](Docs/install-wsl.md)         |
| [list-cli-tools.ps1](Scripts/list-cli-tools.ps1)     | Lists available command-line interface (CLI) tools                 | [Help](Docs/list-cli-tools.md)      |
| [list-drives.ps1](Scripts/list-drives.ps1)           | Lists all drives                                                   | [Help](Docs/list-drives.md)         |
| [list-network-shares.ps1](Scripts/list-network-shares.ps1) | Lists all network shares of the local computer               | [Help](Docs/list-network-shares.md) |
| [list-installed-apps.ps1](Scripts/list-installed-apps.ps1) | Lists the installed Windows Store apps                       | [Help](Docs/list-installed-apps.md) |
| [list-installed-software.ps1](Scripts/list-installed-software.ps1) | Lists the installed software (except Windows Store apps) | [Help](Docs/list-installed-software.md)|
| [list-printers.ps1](Scripts/list-printers.ps1)       | Lists all printer known to the computer                            | [Help](Docs/list-printers.md)       |
| [list-print-jobs.ps1](Scripts/list-print-jobs.ps1) | Lists all jobs of all printers                                       | [Help](Docs/list-print-jobs.md)     |
| [list-processes.ps1](Scripts/list-processes.ps1)     | Lists the local computer processes                                 | [Help](Docs/list-processes.md)      |
| [list-services.ps1](Scripts/list-services.ps1)       | Lists the services on the local computer                           | [Help](Docs/list-services.md)       |
| [list-system-info.ps1](Scripts/list-system-info.ps1) | Lists system information on the local computer                     | [Help](Docs/list-system-info.md)    |
| [list-tasks.ps1](Scripts/list-tasks.ps1)             | Lists all Windows scheduler tasks                                  | [Help](Docs/list-tasks.md)          |
| [list-timezone.ps1](Scripts/list-timezone.ps1)       | Lists the current time zone details                                | [Help](Docs/list-timezone.md)       |
| [list-timezones.ps1](Scripts/list-timezones.ps1)     | Lists all time zones available                                     | [Help](Docs/list-timezones.md)      |
| [list-user-groups.ps1](Scripts/list-user-groups.ps1) | Lists the user groups on the local computer                        | [Help](Docs/list-user-groups.md)    |
| [poweroff.ps1](Scripts/poweroff.ps1)                 | Halts the local computer (needs admin rights)                      | [Help](Docs/poweroff.md)            |
| [query-smart-data.ps1](Scripts/query-smart-data.ps1) | Queries the S.M.A.R.T. data of your HDD/SSD's                      | [Help](Docs/query-smart-data.md)    |
| [reboot.ps1](Scripts/reboot.ps1)                     | Reboots the local computer (needs admin rights)                    | [Help](Docs/reboot.md)              |
| [remove-print-jobs.ps1](Scripts/remove-print-jobs.ps1) | Removes all jobs from all printers                               | [Help](Docs/remove-print-jobs.md)   |
| [restart-network-adapters.ps1](Scripts/restart-network-adapters.ps1) | Restarts all local network adapters                | [Help](Docs/restart-network-adapters.md)|
| [upgrade-ubuntu.ps1](Scripts/upgrade-ubuntu.ps1)     | Upgrades Ubuntu Linux to the latest (LTS) release                  | [Help](Docs/upgrade-ubuntu.md)      |
| [wakeup.ps1](Scripts/wakeup.ps1)                     | Sends a magic packet to a computer to wake him up                  | [Help](Docs/wakeup.md)              |

💻 Scripts for the Desktop
---------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [close-calculator.ps1](Scripts/close-calculator.ps1) | Closes the calculator application                                  | [Help](Docs/close-calculator.md)        |
| [close-cortana.ps1](Scripts/close-cortana.ps1)       | Closes Cortana                                                     | [Help](Docs/close-cortana.md)           |
| [close-chrome.ps1](Scripts/close-chrome.ps1)         | Closes the Chrome browser                                          | [Help](Docs/close-chrome.md)            |
| [close-program.ps1](Scripts/close-program.ps1)       | Closes the given program gracefully                                | [Help](Docs/close-program.md)           |
| [close-edge.ps1](Scripts/close-edge.ps1)             | Closes the Edge browser                                            | [Help](Docs/close-edge.md)              |
| [close-file-explorer.ps1](Scripts/close-file-explorer.ps1)| Closes Microsoft File Explorer                                | [Help](Docs/close-file-explorer.md)     |
| [close-firefox.ps1](Scripts/close-firefox.ps1)       | Closes the Firefox browser                                         | [Help](Docs/close-edge.md)              |
| [close-microsoft-store.ps1](Scripts/close-microsoft-store.ps1)| Closes the Microsoft Store app                            | [Help](Docs/close-microsoft-store.md)   |
| [close-netflix.ps1](Scripts/close-netflix.ps1)       | Closes the Netflix app                                             | [Help](Docs/close-netflix.md)           |
| [close-onedrive.ps1](Scripts/close-onedrive.ps1)     | Closes Microsoft OneDrive                                          | [Help](Docs/close-onedrive.md)          |
| [close-serenade.ps1](Scripts/close-serenade.ps1)     | Closes the Serenade application                                    | [Help](Docs/close-serenade.md)          |
| [close-snipping-tool.ps1](Scripts/close-snipping-tool.ps1)| Closes the Snipping Tool application                          | [Help](Docs/close-snipping-tool.md)     |
| [close-spotify.ps1](Scripts/close-spotify.ps1)       | Closes Spotify                                                     | [Help](Docs/close-spotify.md)           |
| [close-system-settings.ps1](Scripts/close-system-settings.ps1) | Closes the System Settings window                        | [Help](Docs/close-system-settings.md)   |
| [close-task-manager.ps1](Scripts/close-task-manager.ps1) | Closes the Task Manager                                        | [Help](Docs/close-task-manager.md)      |
| [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) | Closes Mozilla Thunderbird                                       | [Help](Docs/close-thunderbird.md)       |
| [close-vlc.ps1](Scripts/close-vlc.ps1)               | Closes the VLC media player application                            | [Help](Docs/close-vlc.md)               |
| [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) | Closes the Windows Terminal application                | [Help](Docs/close-windows-terminal.md)  |
| [enable-god-mode.ps1](Scripts/enable-god-mode.ps1)   | Enables the god mode (adds a new icon to the desktop)              | [Help](Docs/enable-god-mode.md)         |
| [list-clipboard.ps1](Scripts/list-clipboard.ps1)     | Lists the contents of the clipboard                                | [Help](Docs/list-clipboard.md)          |
| [new-email.ps1](Scripts/new-email.ps1)               | Starts the default email client to write a new email               | [Help](Docs/new-email.md)               |
| [open-amazon-website.ps1](Scripts/open-amazon-website.ps1)| Opens Amazon's website                                        | [Help](Docs/open-amazon-website.md)     |
| [open-default-browser.ps1](Scripts/open-default-browser.ps1)| Launches the default Web browser                            | [Help](Docs/open-default-browser.md)    |
| [open-calculator.ps1](Scripts/open-calculator.ps1)   | Starts the calculator program                                      | [Help](Docs/open-calculator.md)         |
| [open-c-drive.ps1](Scripts/open-c-drive.ps1)         | Opens the C: drive folder                                          | [Help](Docs/open-c-drive.md)            |
| [open-downloads-folders.ps1](Scripts/open-downloads-folder.ps1) | Opens the user's downloads folder                       | [Help](Docs/open-downloads-folder.md)   |
| [open-dropbox-folder.ps1](Scripts/open-dropbox-folder.ps1) | Opens the user's Dropbox folder                              | [Help](Docs/open-dropbox-folder.md)     |
| [open-edge.ps1](Scripts/open-edge.ps1)               | Launches the Edge browser                                          | [Help](Docs/open-edge.md)               |
| [open-email-client.ps1](Scripts/open-browser.ps1)    | Starts the default email client                                    | [Help](Docs/open-email-client.md)       |
| [open-facebook-website.ps1](Scripts/open-facebook-website.ps1)| Opens Facebook's website                                  | [Help](Docs/open-facebook-website.md)   |
| [open-file-explorer.ps1](Scripts/open-file-explorer.ps1) | Opens the File Explorer                                        | [Help](Docs/open-file-explorer.md)      |
| [open-firefox.ps1](Scripts/open-firefox.ps1)         | Launches the Firefox browser                                       | [Help](Docs/open-firefox.md)            |
| [open-fritz-box.ps1](Scripts/open-fritz-box.ps1)     | Opens FRITZ!Box's web interface                                    | [Help](Docs/open-fritz-box.md)          |
| [open-github.ps1](Scripts/open-github.ps1)           | Opens GitHub's website                                             | [Help](Docs/open-github.md)             |
| [open-google-contacts.ps1](Scripts/open-google-contacts.ps1) | Opens Google Contacts                                      | [Help](Docs/open-google-contacts.md)    |
| [open-google-earth.ps1](Scripts/open-google-earth.ps1) | Opens Google Earth                                               | [Help](Docs/open-google-earth.md)       |
| [open-google-mail.ps1](Scripts/open-google-mail.ps1) | Opens Google Mail                                                  | [Help](Docs/open-google-mail.md)        |
| [open-google-maps.ps1](Scripts/open-google-maps.ps1) | Opens Google Maps                                                  | [Help](Docs/open-google-maps.md)        |
| [open-google-news.ps1](Scripts/open-google-news.ps1) | Opens Google News                                                  | [Help](Docs/open-google-news.md)        |
| [open-google-play.ps1](Scripts/open-google-play.ps1) | Opens Google Play                                                  | [Help](Docs/open-google-play.md)        |
| [open-google-search.ps1](Scripts/open-google-search.ps1) | Opens Google Search                                            | [Help](Docs/open-google-search.md)      |
| [open-google-translate.ps1](Scripts/open-google-translate.ps1) | Opens Google Translate                                   | [Help](Docs/open-google-translate.md)   |
| [open-home-folder.ps1](Scripts/open-home-folder.ps1) | Opens the user's home folder                                       | [Help](Docs/open-home-folder.md)        |
| [open-music-folder.ps1](Scripts/open-music-folder.ps1)| Opens the user's music folder                                     | [Help](Docs/open-music-folder.md)       |
| [open-netflix.ps1](Scripts/open-netflix.ps1)         | Starts the Netflix app                                             | [Help](Docs/open-netflix.md)            |
| [open-microsoft-store.ps1](Scripts/open-microsoft-store.ps1)| Launches the Microsoft Store app                            | [Help](Docs/open-microsoft-store.md)    |
| [open-notepad.ps1](Scripts/open-notepad.ps1)         | Starts the Notepad app                                             | [Help](Docs/open-notepad.md)            |
| [open-onedrive-folder.ps1](Scripts/open-onedrive-folder.ps1)| Opens the user's OneDrive folder                            | [Help](Docs/open-onedrive-folder.md)    |
| [open-pictures-folder.ps1](Scripts/open-pictures-folder.ps1) | Opens the user's pictures folder                           | [Help](Docs/open-pictures-folder.md)    |
| [open-recycle-bin.ps1](Scripts/open-recycle-bin.ps1) | Opens the user's recycle bin folder                                | [Help](Docs/open-recycle-bin.md)        |
| [open-repos-folder.ps1](Scripts/open-repos-folder.ps1) | Opens the user's Git repositories folder                         | [Help](Docs/open-repos-folder.md)       |
| [open-snipping-tool.ps1](Scripts/open-snipping-tool.ps1)| Starts the Snipping Tool                                        | [Help](Docs/open-snipping-tool.md)      |
| [open-speed-test.ps1](Scripts/open-speed-test.ps1)   | Opens Cloudflare's speed test                                      | [Help](Docs/open-speed-test.md)         |
| [open-spotify.ps1](Scripts/open-spotify.ps1)         | Opens Spotify                                                      | [Help](Docs/open-spotify.md)            |
| [open-system-settings.ps1](Scripts/open-system-settings.ps1)| Opens system settings of Windows                            | [Help](Docs/open-system-settings.md)    |
| [open-task-manager.ps1](Scripts/open-task-manager.ps1)| Starts the Task Manager                                           | [Help](Docs/open-task-manager.md)       |
| [open-videos-folder.ps1](Scripts/open-videos-folder.ps1)| Opens the user's videos folder                                  | [Help](Docs/open-videos-folder.md)      |
| [open-windows-terminal.ps1](Scripts/open-windows-terminal.ps1)| Launches Windows Terminal                                 | [Help](Docs/open-windows-terminal.md)   |
| [open-wikipedia-website.ps1](Scripts/open-wikipedia-website.ps1)| Opens Wikipedia's website                               | [Help](Docs/open-wikipedia-website.md)  |
| [open-youtube-website.ps1](Scripts/open-youtube-website.ps1)| Opens YouTube's website                                     | [Help](Docs/open-youtube-website.md)    |
| [remind-me.ps1](Scripts/remind-me.ps1)               | Creates a scheduled task that will display a popup message         | [Help](Docs/remind-me.md)               |
| [save-screenshot.ps1](Scripts/save-screenshot.ps1)   | Saves a single screenshot                                          | [Help](Docs/save-screenshot.md)         |
| [set-wallpaper.ps1](Scripts/set-wallpaper.ps1)       | Sets the given image as wallpaper                                  | [Help](Docs/set-wallpaper.md)           |

📁 Scripts for Files & Folders 
-------------------------------

| Script                                               | Description                                                        | Help                                |
| ---------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------- |
| [cd-autostart.ps1](Scripts/cd-autostart.ps1)         | Set the working directory to the user's autostart folder           | [Help](Docs/cd-autostart.md)        |
| [cd-desktop.ps1](Scripts/cd-desktop.ps1)             | Set the working directory to the user's desktop folder             | [Help](Docs/cd-desktop.md)          |
| [cd-docs.ps1](Scripts/cd-docs.ps1)                   | Set the working directory to the user's documents folder           | [Help](Docs/cd-docs.md)             |
| [cd-downloads.ps1](Scripts/cd-downloads.ps1)         | Set the working directory to the user's downloads folder           | [Help](Docs/cd-downloads.md)        |
| [cd-dropbox.ps1](Scripts/cd-dropbox.ps1)             | Set the working directory to the user's Dropbox folder             | [Help](Docs/cd-dropbox.md)          |
| [cd-home.ps1](Scripts/cd-home.ps1)                   | Set the working directory to the user's home folder                | [Help](Docs/cd-home.md)             |
| [cd-music.ps1](Scripts/cd-music.ps1)                 | Set the working directory to the user's music folder               | [Help](Docs/cd-music.md)            |  
| [cd-onedrive.ps1](Scripts/cd-onedrive.ps1)           | Set the working directory to the user's OneDrive folder            | [Help](Docs/cd-onedrive.md)         |
| [cd-pics.ps1](Scripts/cd-pics.ps1)                   | Set the working directory to the user's pictures folder            | [Help](Docs/cd-pics.md)             |
| [cd-recycle-bin.ps1](Scripts/cd-recycle-bin.ps1)     | Set the working directory to the user's recycle bin folder         | [Help](Docs/cd-recycle-bin.md)      |
| [cd-repos.ps1](Scripts/cd-repos.ps1)                 | Change the working directory to the user's Git repositories folder | [Help](Docs/cd-repos.md)            |
| [cd-root.ps1](Scripts/cd-root.ps1)                   | Set the working directory to the root directory (C:\ on Windows)   | [Help](Docs/cd-root.md)             |
| [cd-scripts.ps1](Scripts/cd-scripts.ps1)             | Set the working directory to the PowerShell Scripts folder         | [Help](Docs/cd-scripts.md)          |
| [cd-ssh.ps1](Scripts/cd-ssh.ps1)                     | Set the working directory to the user's SSH folder                 | [Help](Docs/cd-ssh.md)              |
| [cd-up.ps1](Scripts/cd-up.ps1)                       | Set the working directory to one directory level up                | [Help](Docs/cd-up.md)               | 
| [cd-up2.ps1](Scripts/cd-up2.ps1)                     | Set the working directory to two directory levels up               | [Help](Docs/cd-up2.md)              |
| [cd-up3.ps1](Scripts/cd-up3.ps1)                     | Set the working directory to three directory levels up             | [Help](Docs/cd-up3.md)              |
| [cd-up4.ps1](Scripts/cd-up4.ps1)                     | Set the working directory to four directory levels up              | [Help](Docs/cd-up4.md)              |
| [cd-videos.ps1](Scripts/cd-videos.ps1)               | Set the working directory to the user's videos folder              | [Help](Docs/cd-videos.md)           |
| [check-symlinks.ps1](Scripts/check-symlinks.ps1)     | Checks every symlink in a directory tree                           | [Help](Docs/check-symlinks.md)      |
| [check-xml-file.ps1](Scripts/check-xml-file.ps1)     | Checks the given XML file for validity                             | [Help](Docs/check-xml-file.md)      |
| [clear-recycle-bin.ps1](Scripts/clear-recycle-bin.ps1) | Removes the content of the recycle bin folder (can not be undo!) | [Help](Docs/clear-recycle-bin.md)   |
| [copy-photos-sorted.ps1](Scripts/copy-photos-sorted.ps1) | Copy image files sorted by year and month                      | [Help](Docs/copy-photos-sorted.md)  |
| [decrypt-file.ps1](Scripts/decrypt-file.ps1)         | Encrypts the given file                                            | [Help](Docs/decrypt-files.md)       |
| [download-dir.ps1](Scripts/download-dir.ps1)         | Downloads a directory tree from the given URL                      | [Help](Docs/download-dir.md)        |
| [download-file.ps1](Scripts/download-file.ps1)       | Downloads a file from the given URL                                | [Help](Docs/download-file.md)       |
| [edit.ps1](Scripts/edit.ps1)                         | Edits the given file with the built-in text editor                 | [Help](Docs/edit.md)                |
| [encrypt-file.ps1](Scripts/encrypt-file.ps1)         | Encrypts the given file                                            | [Help](Docs/encrypt-file.md)        |
| [get-md5.ps1](Scripts/get-md5.ps1)                   | Prints the MD5 checksum of the given file                          | [Help](Docs/get-md5.md)             |
| [get-sha1.ps1](Scripts/get-sha1.ps1)                 | Prints the SHA1 checksum of the given file                         | [Help](Docs/get-sha1.md)            |
| [get-sha256.ps1](Scripts/get-sha256.ps1)             | Prints the SHA256 checksum of the given file                       | [Help](Docs/get-sha256.md)          |
| [inspect-exe.ps1](Scripts/inspect-exe.ps1)           | Prints basic information of the given executable file              | [Help](Docs/inspect-exe.md)         |
| [list-dir-tree.ps1](Scripts/list-dir-tree.ps1)       | Lists the directory tree content                                   | [Help](Docs/list-dir-treep.md)      |
| [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1)   | Lists empty subfolders within the given directory tree             | [Help](Docs/list-empty-dirs.md)     |
| [list-empty-files.ps1](Scripts/list-empty-files.ps1) | Lists empty files within the given directory tree                  | [Help](Docs/list-empty-files.md)    |
| [list-files.ps1](Scripts/list-files.ps1)             | Lists all files in the given folder and also in every subfolder    | [Help](Docs/list-files.md)          |
| [list-folder.ps1](Scripts/list-folder.ps1)           | Lists the folder content                                           | [Help](Docs/list-folder.md)         |
| [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) | Lists hidden files within the given directory tree               | [Help](Docs/list-hidden-files.md)   |
| [list-recycle-bin.ps1](Scripts/list-recycle-bin.ps1) | Lists the content of the recycle bin folder                        | [Help](Docs/list-recycle-bin.md)    |
| [list-unused-files.ps1](Scripts/list-unused-files.ps1) | Lists unused files in a directory tree                           | [Help](Docs/list-unused-files.md)   |
| [list-workdir.ps1](Scripts/list-workdir.ps1)         | Lists the current working directory                                | [Help](Docs/list-workdir.md)        |
| [make-install.ps1](Scripts/make-install.ps1)         | Installs built executables and libs to the installation directory  | [Help](Docs/make-install.md)        |
| [new-shortcut.ps1](Scripts/new-shortcut.ps1)         | Creates a new shortcut file                                        | [Help](Docs/new-shortcut.md)        |
| [new-symlink.ps1](Scripts/new-symlink.ps1)           | Creates a new symbolic link file                                   | [Help](Docs/new-symlink.md)         |
| [new-zipfile.ps1](Scripts/new-zipfile.ps1)           | Creates a new .zip file from a directory                           | [Help](Docs/new-zipfile.md)         |
| [publish-to-ipfs.ps1](Scripts/publish-to-ipfs.ps1)   | Publishes the given files or directory to IPFS                     | [Help](Docs/publish-to-ipfs.md)     |
| [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) | Removes empty subfolders within the given directory tree         | [Help](Docs/remove-empty-dirs.md)   |
| [replace-in-files.ps1](Scripts/replace-in-files.ps1) | Search and replace a pattern in the given files by the replacement | [Help](Docs/replace-in-files.md)    |
| [search-filename.ps1](Scripts/search-filename.ps1)   | Searches the directory tree for filenames by given pattern         | [Help](Docs/search-filename.md)     |
| [search-files.ps1](Scripts/search-files.ps1)         | Searches the given pattern in the given files                      | [Help](Docs/search-files.md)        |
| [upload-file.ps1](Scripts/upload-file.ps1)           | Uploads the local file to the given FTP server                     | [Help](Docs/upload-file.md)         |

♻️ Scripts to Convert Files
---------------------------

| Script                                                 | Description                                                        | Help                                  |
| ------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------- |
| [convert-csv2txt.ps1](Scripts/convert-csv2txt.ps1)     | Converts a given .CSV file to a text file                          | [Help](Docs/convert-csv2txt.md)       |
| [convert-mysql2csv.ps1](Scripts/convert-mysql2csv.ps1) | Converts a MySQL database table to a .CSV file                     | [Help](Docs/convert-mysql2csv.md)     |
| [convert-ps2bat.ps1](Scripts/convert-ps2bat.ps1)       | Converts a PowerShell script to a .BAT file                        | [Help](Docs/convert-ps2bat.md)        |
| [convert-ps2md.ps1](Scripts/convert-ps2md.ps1)         | Converts the comment-based help of a PowerShell script to Markdown | [Help](Docs/convert-ps2md.md)         |
| [convert-sql2csv.ps1](Scripts/convert-sql2csv.ps1)     | Converts a SQL database table to a .CSV file                       | [Help](Docs/convert-sql2csv.md)       |
| [convert-txt2wav.ps1](Scripts/convert-txt2wav.ps1)     | Converts text to a .WAV audio file                                 | [Help](Docs/convert-txt2wav.md)       |
| [export-to-manuals.ps1](Scripts/export-to-manuals.ps1) | Exports all scripts as manuals                                     | [Help](Docs/export-to-manuals.md)     |
| [export-to-serenade.ps1](Scripts/export-to-serenade.ps1)| Exports all scripts to Serenade for voice control                 | [Help](Docs/export-to-serenade.md)    |


📝 Scripts for Git
-------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [build-repo.ps1](Scripts/build-repo.ps1)             | Builds a Git repository                                            | [Help](Docs/build-repo.md)              |
| [build-repos.ps1](Scripts/build-repos.ps1)           | Builds all Git repositories in a folder                            | [Help](Docs/build-repos.md)             |
| [clean-repo.ps1](Scripts/clean-repo.ps1)             | Cleans a Git repository from untracked files (including submodules) | [Help](Docs/clean-repo.md)             |
| [clean-repos.ps1](Scripts/clean-repos.ps1)           | Cleans all Git repositories in a folder from untracked files (including submodules) | [Help](Docs/clean-repos.md) |
| [clone-repos.ps1](Scripts/clone-repos.ps1)           | Clones well-known Git repositories                                 | [Help](Docs/clone-repos.md)             |
| [configure-git.ps1](Scripts/configure-git.ps1)       | Sets up the Git user configuration                                 | [Help](Docs/configure-git.md)           |
| [fetch-repo.ps1](Scripts/fetch-repo.ps1)             | Fetches updates for a Git repository (including submodules)        | [Help](Docs/fetch-repo.md)              |
| [fetch-repos.ps1](Scripts/fetch-repos.ps1)           | Fetches updates for all Git repositories in a folder (including submodules) | [Help](Docs/fetch-repos.md)    |
| [list-branches.ps1](Scripts/list-branches.ps1)       | Lists all branches in a Git repository                             | [Help](Docs/list-branches.md)           |
| [list-commits.ps1](Scripts/list-commits.ps1)         | Lists all commits in a Git repository                              | [Help](Docs/list-commits.md)            |
| [list-latest-tag.ps1](Scripts/list-latest-tag.ps1)   | Lists the latest tag on the current branch in a Git repository     | [Help](Docs/list-latest-tag.md)         |
| [list-latest-tags.ps1](Scripts/list-latest-tags.ps1) | Lists the latests tags in all Git repositories under a directory   | [Help](Docs/list-latest-tags.md)        |
| [list-submodules.ps1](Scripts/list-submodules.ps1)   | Lists the submodules in a Git repository                           | [Help](Docs/list-submodules.md)         |
| [list-tags.ps1](Scripts/list-tags.ps1)               | Lists all tags in a Git repository                                 | [Help](Docs/list-tags.md)               |
| [new-branch.ps1](Scripts/new-branch.ps1)             | Creates a new branch in a Git repository                           | [Help](Docs/new-branch.md)              |
| [new-tag.ps1](Scripts/new-tag.ps1)                   | Creates a new tag in a Git repository                              | [Help](Docs/new-tag.md)                 |
| [pick-commit.ps1](Scripts/pick-commit.ps1)           | Cherry-picks a Git commit into multiple branches                   | [Help](Docs/pick-commit.md)             |
| [pull-repo.ps1](Scripts/pull-repo.ps1)               | Pulls updates for a Git repository (including submodules)          | [Help](Docs/pull-repo.md)               |
| [pull-repos.ps1](Scripts/pull-repos.ps1)             | Pulls updates for all Git repositories in a folder (including submodules) | [Help](Docs/pull-repos.md)       |
| [remove-tag.ps1](Scripts/remove-tag.ps1)             | Removes a tag in a Git repository                                  | [Help](Docs/remove-tag.md)              |
| [switch-branch.ps1](Scripts/switch-branch.ps1)       | Switches the branch in a Git repository (including submodules)     | [Help](Docs/switch-branch.md)           |
| [sync-repo.ps1](Scripts/sync-repo.ps1)               | Synchronizes a Git repository by push & pull (including submodules)| [Help](Docs/sync-repo.md)               |

🔎 Scripts for PowerShell 
------------------------

| Script                                                 | Description                                                        | Help                                  |
| ------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------- |
| [daily-tasks.sh](Scripts/daily-tasks.sh)               | Execute PowerShell scripts automatically as daily tasks (Linux only) | [Help](Docs/daily-tasks.sh.md)      |
| [introduce-powershell.ps1](Scripts/introduce-powershell.ps1) | Introduces PowerShell to new users                           | [Help](Docs/introduce-powershell.md)  |
| [list-aliases.ps1](Scripts/list-aliases.ps1)           | Lists all PowerShell aliases                                       | [Help](Docs/list-aliases.md)          |
| [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) | Lists the automatic variables of PowerShell          | [Help](Docs/list-automatic-variables.md)|
| [list-cheat-sheet.ps1](Scripts/list-cheat-sheet.ps1)   | Lists the PowerShell cheat sheet                                   | [Help](Docs/list-cheat-sheet.md)      |
| [list-cmdlets.ps1](Scripts/list-cmdlets.ps1)           | Lists the PowerShell cmdlets                                       | [Help](Docs/list-cmdlets.md)          |
| [list-console-colors.ps1](Scripts/list-console-colors.ps1) | Lists all console colors                                       | [Help](Docs/list-console-colors.md)   |
| [list-modules.ps1](Scripts/list-modules.ps1)           | Lists the PowerShell modules                                       | [Help](Docs/list-modules.md)          |
| [list-profiles.ps1](Scripts/list-profiles.ps1)         | Lists your PowerShell profiles                                     | [Help](Docs/list-profiles.md)         |
| [list-scripts.ps1](Scripts/list-scripts.ps1)           | Lists all PowerShell scripts in this repository                    | [Help](Docs/list-scripts.md)          |
| [new-script.ps1](Scripts/new-script.ps1)               | Creates a new PowerShell script                                    | [Help](Docs/new-script.md)            |
| [set-profile.ps1](Scripts/set-profile.ps1)             | Updates your PowerShell user profile                               | [Help](Docs/set-profile.md)           |

🛒 Various PowerShell Scripts 
------------------------------

| Script                                               | Description                                                        | Help                                    |
| ---------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------- |
| [add-memo.ps1](Scripts/add-memo.ps1)                 | Adds the given memo text to $HOME/Memos.csv                        | [Help](Docs/add-memo.md)                |
| [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1)| Checks the given IPv4 address for validity                      | [Help](Docs/check-ipv4-address.md)      |
| [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1)| Checks the given IPv6 address for validity                      | [Help](Docs/check-ipv6-address.md)      |
| [check-mac-address.ps1](Scripts/check-mac-address.ps1)| Checks the given MAC address for validity                         | [Help](Docs/check-mac-address.md)       |
| [check-subnet-mask.ps1](Scripts/check-subnet-mask.ps1)| Checks the given subnet mask for validity                         | [Help](Docs/check-subnet-mask.md)       |
| [check-weather.ps1](Scripts/check-weather.ps1)       | Checks the current weather for critical values                     | [Help](Docs/check-weather.md)           |
| [display-time.ps1](Scripts/display-time.ps1)         | Displays the current time for 10 seconds by default                | [Help](Docs/display-time.md)            |
| [list-anagrams.ps1](Scripts/list-anagrams.ps1)       | Lists all anagrams of the given word                               | [Help](Docs/list-anagrams.md)           |
| [list-city-weather.ps1](Scripts/list-city-weather.ps1)| Lists the current weather of cities worldwide (west to east)      | [Help](Docs/list-city-weather.md)       |
| [list-countries.ps1](Scripts/list-countries.ps1)     | Lists details of all countries                                     | [Help](Docs/list-countries.md)          |
| [list-credits.ps1](Scripts/list-credits.ps1)         | Shows the credits                                                  | [Help](Docs/list-credits.md)            |
| [list-crypto-rates.ps1](Scripts/list-crypto-rates.ps1)| Lists the current crypto exchange rates                           | [Help](Docs/list-crypto-rates.md)       |
| [list-environment-variables.ps1](Scripts/list-environment-variables.ps1)| Lists all environment variables                 | [Help](Docs/list-environment-variables.md)|
| [list-emojis.ps1](Scripts/list-emojis.ps1)           | Lists the emojis of Unicode 13.0                                   | [Help](Docs/list-emojis.md)             |
| [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1)| Lists the FRITZ!Box calls                                     | [Help](Docs/list-fritzbox-calls.md)     |
| [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1)| Lists FRITZ!Box's known devices                           | [Help](Docs/list-fritzbox-devices.md)   |
| [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) | Lists earthquakes with magnitude >= 6.0 for the last 30 days       | [Help](Docs/list-earthquakes.md)        |
| [list-exchange-rates.ps1](Scripts/list-exchange-rates.ps1)| Lists the current exchange rates for the given currency       | [Help](Docs/list-exchange-rates.md)     |
| [list-memos.ps1](Scripts/list-memos.ps1)             | Lists the memos at $HOME/Memos.csv                                 | [Help](Docs/list-memos.md)              |
| [list-mysql-tables.ps1](Scripts/list-mysql-tables.ps1)| Lists the MySQL server tables                                     | [Help](Docs/list-mysql-tables.md)       |
| [list-news.ps1](Scripts/list-news.ps1)               | Lists the latest news                                              | [Help](Docs/list-news.md)               |
| [list-os-releases.ps1](Scripts/list-os-releases.ps1) | Lists operating system releases and download URL                   | [Help](Docs/list-os-releases.md)        |
| [list-os-updates.ps1](Scripts/list-os-updates.ps1)   | Lists operating system updates                                     | [Help](Docs/list-os-updates.md)         |
| [list-passwords.ps1](Scripts/list-passwords.ps1)     | Prints a list of random passwords                                  | [Help](Docs/list-passwords.md)          |
| [list-pins.ps1](Scripts/list-pins.ps1)               | Prints a list of random PIN's                                      | [Help](Docs/list-pins.md)               |
| [list-sql-tables.ps1](Scripts/list-sql-tables.ps1)   | Lists the SQL server tables                                        | [Help](Docs/list-sql-tables.md)         |
| [list-tiobe-index.ps1](Scripts/list-tiobe-index.ps1) | Lists the TIOBE index of top programming languages                 | [Help](Docs/list-tiobe-index.md)        |
| [list-weather.ps1](Scripts/list-weather.ps1)         | Lists the hourly weather                                           | [Help](Docs/list-weather.md)            |
| [locate-city.ps1](Scripts/locate-city.ps1)           | Prints the geographic location of the given city                   | [Help](Docs/locate-city.md)             |
| [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) | Prints the geographic location of the given IP address             | [Help](Docs/locate-ipaddress.md)        |
| [locate-zip-code.ps1](Scripts/locate-zip-code.ps1)   | Prints the geographic location of the given zip-code               | [Help](Docs/locate-zip-code.md)         |
| [moon.ps1](Scripts/moon.ps1)                         | Prints the current moon phase                                      | [Help](Docs/moon.md)                    |
| [new-qrcode.ps1](Scripts/new-qrcode.ps1)             | Generates a new QR code image file                                 | [Help](Docs/new-qrcode.md)              |
| [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1)   | Reboots the FRITZ!box device                                       | [Help](Docs/reboot-fritzbox.md)         |
| [scan-ports.ps1](Scripts/scan-ports.ps1)             | Scans the network for open/closed ports                            | [Help](Docs/scan-ports.md)              |
| [send-email.ps1](Scripts/send-email.ps1)             | Sends an email message                                             | [Help](Docs/send-email.md)              |
| [send-tcp.ps1](Scripts/send-udp.ps1)                 | Sends a TCP message to the given IP address and port               | [Help](Docs/send-tcp.md)                |
| [send-udp.ps1](Scripts/send-udp.ps1)                 | Sends a UDP datagram message to the given IP address and port      | [Help](Docs/send-udp.md)                |
| [set-timer.ps1](Scripts/set-timer.ps1)               | Sets a timer for a countdown                                       | [Help](Docs/set-timer.md)               |
| [simulate-matrix.ps1](Scripts/simulate-matrix.ps1)   | Simulates the Matrix (fun)                                         | [Help](Docs/simulate-matrix.md)         |
| [simulate-presence.ps1](Scripts/simulate-presence.ps1)| Simulates the human presence against burglars                     | [Help](Docs/simulate-presence.md)       |
| [start-calibre-server.ps1](Scripts/start-calibre-server.ps1)| Starts a local Calibre server                               | [Help](Docs/start-calibre-server.md)    |
| [start-ipfs-server.ps1](Scripts/start-ipfs-server.ps1)| Starts a local IPFS server                                        | [Help](Docs/start-ipfs-server.md)       |
| [switch-shelly1.ps1](Scripts/switch-shelly1.ps1)     | Switches a Shelly1 device in the local network                     | [Help](Docs/switch-shelly1.md)          |
| [translate-file.ps1](Scripts/translate-file.ps1)     | Translates the given text file into other languages                | [Help](Docs/translate-file.md)          |
| [translate-files.ps1](Scripts/translate-files.ps1)   | Translates the given text files into any supported language        | [Help](Docs/translate-files.md)         |
| [translate-text.ps1](Scripts/translate-text.ps1)     | Translates the given text in English into other languages          | [Help](Docs/translate-text.md)          |
| [weather.ps1](Scripts/weather.ps1)                   | Prints the current weather forecast                                | [Help](Docs/weather.md)                 |
| [weather-report.ps1](Scripts/weather-report.ps1)     | Prints the local weather report                                    | [Help](Docs/weather-report.md)          |
| [what-is.ps1](Scripts/what-is.ps1)                   | Prints a description of the given abbreviation                     | [Help](Docs/what-is.md)                 |
| [write-animated.ps1](Scripts/write-animated.ps1)     | Writes animated text                                               | [Help](Docs/write-animated.md)          |
| [write-big.ps1](Scripts/write-big.ps1)               | Writes the given text in big letters                               | [Help](Docs/write-big.md)               |
| [write-blue.ps1](Scripts/write-blue.ps1)             | Writes the given text in a blue foreground color                   | [Help](Docs/write-blue.md)              |
| [write-braille.ps1](Scripts/write-braille.ps1)       | Writes the given text in Braille                                   | [Help](Docs/write-braille.md)           |
| [write-calendar.ps1](Scripts/write-calendar.ps1)     | Writes the calendar (month of year)                                | [Help](Docs/write-calendar.md)          |
| [write-green.ps1](Scripts/write-green.ps1)           | Writes the given text in a green foreground color                  | [Help](Docs/write-green.md)             |
| [write-joke.ps1](Scripts/write-joke.ps1)             | Writes a random Juck Norris joke                                   | [Help](Docs/write-joke.md)              |
| [write-lowercase.ps1](Scripts/write-lowercase.ps1)   | Writes the given text in lowercase letters                         | [Help](Docs/write-lowercase.md)         |
| [write-marquee.ps1](Scripts/write-marquee.ps1)       | Writes the given text as marquee                                   | [Help](Docs/write-marquee.md)           |
| [write-morse-code.ps1](Scripts/write-morse-code.ps1) | Writes the given text in Morse code                                | [Help](Docs/write-morse-code.md)        |
| [write-motd.ps1](Scripts/write-motd.ps1)             | Writes the message of the day (MOTD)                               | [Help](Docs/write-motd.md)              |
| [write-quote.ps1](Scripts/write-quote.ps1)           | Writes a random quote                                              | [Help](Docs/write-quote.md)             |
| [write-red.ps1](Scripts/write-red.ps1)               | Writes the given text in a red foreground color                    | [Help](Docs/write-red.md)               |
| [write-rot13.ps1](Scripts/write-rot13.ps1)           | Encodes or decodes the given text with ROT13                       | [Help](Docs/write-rot13.md)             |
| [write-typewriter.ps1](Scripts/write-typewriter.ps1) | Writes the given text with the typewriter effect                   | [Help](Docs/write-typewriter.md)        |
| [write-uppercase.ps1](Scripts/write-uppercase.ps1)   | Writes the given text in uppercase letters                         | [Help](Docs/write-uppercase.md)         |
| [write-vertical.ps1](Scripts/write-vertical.ps1)     | Writes the given text in vertical direction                        | [Help](Docs/write-vertical.md)          |

Feedback
--------
Send your email feedback to: markus [at] fleschutz [dot] de

License, Copyright & Trademarks
-------------------------------
This open source release is licensed under the CC0 license. All trademarks are the property of their respective owners.
