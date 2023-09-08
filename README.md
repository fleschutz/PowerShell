Mega Collection of PowerShell Scripts
=====================================

**It includes 500+ useful cross-platform PowerShell scripts located in the [📂Scripts](Scripts/) subfolder - for the command-line interface (CLI), for remote control via SSH, for automation (e.g. [AutoHotkey](https://www.autohotkey.com/) or [Jenkins](https://www.jenkins.io/)), for context menus, for voice commands (e.g. [talk2windows](https://github.com/fleschutz/talk2windows)), automatically on startup/login/logoff/daily/shutdown/etc., or simply to learn PowerShell.**

**[Download](https://github.com/fleschutz/PowerShell/releases) | [Table of Scripts](https://github.com/fleschutz/PowerShell/blob/master/Data/scripts.csv) | [FAQ](Docs/FAQ.md)** | **Note:** the scripts support Unicode - a modern console is recommended (e.g. *Windows Terminal*)

🔊 Scripts for Audio & Voice 
-----------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [list-voices.ps1](Scripts/list-voices.ps1)           | Lists the installed text-to-speech voices. [Read more...](Docs/list-voices.md)                  |
| [play-beep-sound.ps1](Scripts/play-beep-sound.ps1)   | Plays a short beep sound. [Read more...](Docs/play-beep-sound.md)                               |
| [play-files.ps1](Scripts/play-files.ps1)             | Plays the given audio files. [Read more...](Docs/play-files.md)                                 |
| [play-happy-birthday.ps1](Scripts/play-happy-birthday.ps1) | Plays the Happy Birthday song. [Read more...](Docs/play-happy-birthday.md)                |
| [play-imperial-march.ps1](Scripts/play-imperial-march.ps1) | Plays the Imperial March (Star Wars). [Read more...](Docs/play-imperial-march.md)         |
| [play-jingle-bells.ps1](Scripts/play-jingle-bells.ps1) | Plays Jingle Bells. [Read more...](Docs/play-jingle-bells.md)                                 |
| [play-mission-impossible.ps1](Scripts/play-mission-impossible.ps1) | Plays the Mission Impossible theme. [Read more...](Docs/play-mission-impossible.md)|
| [play-m3u.ps1](Scripts/play-m3u.ps1)                 | Plays the given playlist (M3U file format). [Read more...](Docs/play-m3u.md)                    |
| [play-mp3.ps1](Scripts/play-mp3.ps1)                 | Plays the given sound file (MP3 file format). [Read more...](Docs/play-mp3.md)                  |
| [play-super-mario.ps1](Scripts/play-super-mario.ps1) | Plays the Super Mario intro. [Read more...](Docs/play-super-mario.md)                           |
| [play-tetris-melody.ps1](Scripts/play-tetris-melody.ps1) | Plays the Tetris melody. [Read more...](Docs/play-tetris-melody.md)                         |
| [speak-checklist.ps1](Scripts/speak-checklist.ps1)   | Speaks the given checklist by text-to-speech. [Read more...](Docs/speak-checklist.md)           |
| [speak-countdown.ps1](Scripts/speak-countdown.ps1)   | Starts a countdown by text-to-speech. [Read more...](Docs/speak-countdown.md)                   |
| [speak-english.ps1](Scripts/speak-english.ps1)       | Speaks text with an English text-to-speech voice. [Read more...](Docs/speak-english.md)         |
| [speak-epub.ps1](Scripts/speak-epub.ps1)             | Speaks the content of the given Epub file by text-to-speech. [Read more...](Docs/speak-epub.md) |
| [speak-file.ps1](Scripts/speak-file.ps1)             | Speaks the content of the given text file by text-to-speech. [Read more...](Docs/speak-file.md) |
| [speak-french.ps1](Scripts/speak-french.ps1)         | Speaks text with a French text-to-speech voice. [Read more...](Docs/speak-french.md)            |
| [speak-german.ps1](Scripts/speak-german.ps1)         | Speaks text with a German text-to-speech voice. [Read more...](Docs/speak-german.md)            |
| [speak-italian.ps1](Scripts/speak-italian.ps1)       | Speaks text with an Italian text-to-speech voice. [Read more...](Docs/speak-italian.md)         |
| [speak-spanish.ps1](Scripts/speak-spanish.ps1)       | Speaks text with a Spanish text-to-speech voice. [Read more...](Docs/speak-spanish.md)          |
| [speak-test.ps1](Scripts/speak-test.ps1)             | Performs a speak test by text-to-speech. [Read more...](Docs/speak-test.md)                     |
| [speak-text.ps1](Scripts/speak-text.ps1)             | Speaks the given text by text-to-speech. [Read more...](Docs/speak-text.md)                     |
| [tell-joke.ps1](Scripts/tell-joke.ps1)               | Tells a random joke by text-to-speech. [Read more...](Docs/tell-joke.md)                        |
| [tell-quote.ps1](Scripts/tell-quote.ps1)             | Tells a random quote by text-to-speech. [Read more...](Docs/tell-quote.md)                      |
| [turn-volume-down.ps1](Scripts/turn-volume-down.ps1) | Turns the audio volume down. [Read more...](Docs/turn-volume-down.md)                           |
| [turn-volume-fully-up.ps1](Scripts/turn-volume-fully-up.ps1) | Turns the audio volume fully up. [Read more...](Docs/turn-volume-fully-up.md)           |
| [turn-volume-off.ps1](Scripts/turn-volume-off.ps1)   | Turns audio off. [Read more...](Docs/turn-volume-off-audio.md)                                  |
| [turn-volume-on.ps1](Scripts/turn-volume-on.ps1)     | Turns audio on. [Read more...](Docs/turn-volume-on.md)                                          |
| [turn-volume-up.ps1](Scripts/turn-volume-up.ps1)     | Turns the audio volume up. [Read more...](Docs/turn-volume-up.md)                               |


⚙️ Scripts to Manage Computers
-------------------------------

| Script                                               | Description                                                                                       |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| [add-firewall-rules.ps1](Scripts/add-firewall-rules.ps1) | Adds firewall rules for executables, needs admin rights. [Read more...](Docs/add-firewall-rules.md) |
| [check-cpu.ps1](Scripts/check-cpu.ps1)| Checks the CPU temperature. [Read more...](Docs/check-cpu.md)                                                    |
| [check-dns.ps1](Scripts/check-dns.ps1) | Checks the DNS resolution. [Read more...](Docs/check-dns.md)                                                    |
| [check-drive-space.ps1](Scripts/check-drive-space.ps1) | Checks a drive for free space left. [Read more...](Docs/check-drive-space.md)                   |
| [check-file-system.ps1](Scripts/check-file-system.ps1) | Checks the file system of a drive (needs admin rights). [Read more...](Docs/check-file-system.md)|
| [check-health.ps1](Scripts/check-health.ps1)         | Checks the system health. [Read more...](Docs/check-health.md)                                    |
| [check-ping.ps1](Scripts/check-ping.ps1)             | Checks the ping latency to the internet. [Read more...](Docs/check-ping.md)                       |
| [check-swap-space.ps1](Scripts/check-swap-space.ps1) | Checks the swap space for free space left. [Read more...](Docs/check-swap-space.md)               |
| [check-windows-system-files.ps1](Scripts/check-windows-system-files.ps1) | Checks the validity of the Windows system files (needs admin rights). [Read more...](Docs/check-windows-system-files.md) |
| [enable-crash-dumps.ps1](Scripts/enable-crash-dumps.ps1) | Enables the writing of crash dumps. [Read more...](Docs/enable-crash-dumps.md)                |
| [hibernate.ps1](Scripts/hibernate.ps1)               | Hibernates the local computer immediately. [Read more...](Docs/hibernate.md)                      |
| [install-github-cli.ps1](Scripts/install-github-cli.ps1) | Installs GitHub CLI. [Read more...](Docs/install-github-cli.md)                               |
| [install-chrome-browser.ps1](Scripts/install-chrome-browser.ps1) | Installs the Google Chrome browser. [Read more...](Docs/install-chrome-browser.md)    |
| [install-firefox.ps1](Scripts/install-firefox.ps1)   | Installs the Firefox browser. [Read more...](Docs/install-firefox.md)    |
| [install-knot-resolver.ps1](Scripts/install-knot-resolver.ps1) | Installs the Knot Resolver (needs admin rights). [Read more...](Docs/install-knot-resolver.md)|
| [install-ssh-client.ps1](Scripts/install-ssh-client.ps1) | Installs a SSH client (needs admin rights). [Read more...](Docs/install-ssh-client.md)        |
| [install-ssh-server.ps1](Scripts/install-ssh-server.ps1) | Installs a SSH server (needs admin rights). [Read more...](Docs/install-ssh-server.md)        |
| [install-signal-cli.ps1](Scripts/install-signal-cli.ps1) | Installs signal-cli from github.com/AsamK/signal-cli. [Read more...](Docs/install-signal-cli.md)|
| [install-updates.ps1](Scripts/install-updates.ps1)   | Installs updates (need admin rights). [Read more...](Docs/install-updates.md)                     |
| [install-wsl.ps1](Scripts/install-wsl.ps1)           | Installs Windows Subsystem for Linux (WSL), needs admin rights. [Read more...](Docs/install-wsl.md)|
| [list-apps.ps1](Scripts/list-apps.ps1)               | Lists the installed applications. [Read more...](Docs/list-installed-apps.md)                     |
| [list-cli-tools.ps1](Scripts/list-cli-tools.ps1)     | Lists installed command-line interface (CLI) tools. [Read more...](Docs/list-cli-tools.md)        |
| [list-dns-servers.ps1](Scripts/list-dns-servers.ps1) | Lists public DNS servers. [Read more...](Docs/list-dns-servers.md)                                |
| [list-drives.ps1](Scripts/list-drives.ps1)           | Lists all drives. [Read more...](Docs/list-drives.md)                                             |
| [list-network-shares.ps1](Scripts/list-network-shares.ps1) | Lists all network shares of the local computer. [Read more...](Docs/list-network-shares.md) |
| [list-installed-software.ps1](Scripts/list-installed-software.ps1) | Lists the installed software. [Read more...](Docs/list-installed-software.md)       |
| [list-printers.ps1](Scripts/list-printers.ps1)       | Lists all printer known to the computer. [Read more...](Docs/list-printers.md)                    |
| [list-print-jobs.ps1](Scripts/list-print-jobs.ps1)   | Lists all jobs of all printers. [Read more...](Docs/list-print-jobs.md)                           |
| [list-processes.ps1](Scripts/list-processes.ps1)     | Lists the local computer processes. [Read more...](Docs/list-processes.md)                        |
| [list-services.ps1](Scripts/list-services.ps1)       | Lists the services on the local computer. [Read more...](Docs/list-services.md)                   |
| [list-system-info.ps1](Scripts/list-system-info.ps1) | Lists system information on the local computer. [Read more...](Docs/list-system-info.md)          |
| [list-tasks.ps1](Scripts/list-tasks.ps1)             | Lists all Windows scheduler tasks. [Read more...](Docs/list-tasks.md)                             |
| [list-timezone.ps1](Scripts/list-timezone.ps1)       | Lists the current time zone details. [Read more...](Docs/list-timezone.md)                        |
| [list-timezones.ps1](Scripts/list-timezones.ps1)     | Lists all time zones available. [Read more...](Docs/list-timezones.md)                            |
| [list-user-groups.ps1](Scripts/list-user-groups.ps1) | Lists the user groups on the local computer. [Read more...](Docs/list-user-groups.md)             |
| [poweroff.ps1](Scripts/poweroff.ps1)                 | Halts the local computer (needs admin rights). [Read more...](Docs/poweroff.md)                   |
| [query-smart-data.ps1](Scripts/query-smart-data.ps1) | Queries the S.M.A.R.T. data of your HDD/SSD's. [Read more...](Docs/query-smart-data.md)           |
| [reboot.ps1](Scripts/reboot.ps1)                     | Reboots the local computer (needs admin rights). [Read more...](Docs/reboot.md)                   |
| [remove-print-jobs.ps1](Scripts/remove-print-jobs.ps1) | Removes all jobs from all printers. [Read more...](Docs/remove-print-jobs.md)                   |
| [restart-network-adapters.ps1](Scripts/restart-network-adapters.ps1) | Restarts all local network adapters. [Read more...](Docs/restart-network-adapters.md)|
| [upgrade-ubuntu.ps1](Scripts/upgrade-ubuntu.ps1)     | Upgrades Ubuntu Linux to the latest (LTS) release. [Read more...](Docs/upgrade-ubuntu.md)         |
| [wake-up.ps1](Scripts/wake-up.ps1)                   | Wakes up a computer using Wake-on-LAN. [Read more...](Docs/wakeup.md)                             |

💻 Scripts for the Desktop
---------------------------

| Script                                               | Description                                                                                 |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| [close-calculator.ps1](Scripts/close-calculator.ps1) | Closes the calculator application. [Read more...](Docs/close-calculator.md)                 |
| [close-cortana.ps1](Scripts/close-cortana.ps1)       | Closes Cortana. [Read more...](Docs/close-cortana.md)                                       |
| [close-chrome.ps1](Scripts/close-chrome.ps1)         | Closes the Chrome browser. [Read more...](Docs/close-chrome.md)                             |
| [close-program.ps1](Scripts/close-program.ps1)       | Closes the given program gracefully. [Read more...](Docs/close-program.md)                  |
| [close-edge.ps1](Scripts/close-edge.ps1)             | Closes the Edge browser. [Read more...](Docs/close-edge.md)                                 |
| [close-file-explorer.ps1](Scripts/close-file-explorer.ps1)| Closes Microsoft File Explorer. [Read more...](Docs/close-file-explorer.md)            |
| [close-firefox.ps1](Scripts/close-firefox.ps1)       | Closes the Firefox browser. [Read more...](Docs/close-edge.md)                              |
| [close-microsoft-store.ps1](Scripts/close-microsoft-store.ps1)| Closes the Microsoft Store app. [Read more...](Docs/close-microsoft-store.md)      |
| [close-netflix.ps1](Scripts/close-netflix.ps1)       | Closes the Netflix app. [Read more...](Docs/close-netflix.md)                               |
| [close-onedrive.ps1](Scripts/close-onedrive.ps1)     | Closes Microsoft OneDrive. [Read more...](Docs/close-onedrive.md)                           |
| [close-serenade.ps1](Scripts/close-serenade.ps1)     | Closes the Serenade application. [Read more...](Docs/close-serenade.md)                     |
| [close-snipping-tool.ps1](Scripts/close-snipping-tool.ps1)| Closes the Snipping Tool application. [Read more...](Docs/close-snipping-tool.md)      |
| [close-spotify.ps1](Scripts/close-spotify.ps1)       | Closes Spotify. [Read more...](Docs/close-spotify.md)                                       |
| [close-system-settings.ps1](Scripts/close-system-settings.ps1) | Closes the System Settings window. [Read more...](Docs/close-system-settings.md)  |
| [close-task-manager.ps1](Scripts/close-task-manager.ps1) | Closes the Task Manager. [Read more...](Docs/close-task-manager.md)                     |
| [close-thunderbird.ps1](Scripts/close-thunderbird.ps1) | Closes Mozilla Thunderbird. [Read more...](Docs/close-thunderbird.md)                     |
| [close-vlc.ps1](Scripts/close-vlc.ps1)               | Closes the VLC media player application. [Read more...](Docs/close-vlc.md)                  |
| [close-windows-terminal.ps1](Scripts/close-windows-terminal.ps1) | Closes the Windows Terminal application. [Read more...](Docs/close-windows-terminal.md)  |
| [enable-god-mode.ps1](Scripts/enable-god-mode.ps1)   | Enables the god mode (adds a new icon to the desktop). [Read more...](Docs/enable-god-mode.md) |
| [list-clipboard.ps1](Scripts/list-clipboard.ps1)     | Lists the contents of the clipboard. [Read more...](Docs/list-clipboard.md)                 |
| [new-email.ps1](Scripts/new-email.ps1)               | Starts the default email client to write a new email. [Read more...](Docs/new-email.md)     |
| [open-amazon-website.ps1](Scripts/open-amazon-website.ps1)| Opens Amazon's website. [Read more...](Docs/open-amazon-website.md)                    |
| [open-default-browser.ps1](Scripts/open-default-browser.ps1)| Launches the default Web browser. [Read more...](Docs/open-default-browser.md)       |
| [open-calculator.ps1](Scripts/open-calculator.ps1)   | Starts the calculator program. [Read more...](Docs/open-calculator.md)                      |
| [open-c-drive.ps1](Scripts/open-c-drive.ps1)         | Opens the C: drive folder. [Read more...](Docs/open-c-drive.md)                             |
| [open-downloads-folders.ps1](Scripts/open-downloads-folder.ps1) | Opens the user's downloads folder. [Read more...](Docs/open-downloads-folder.md) |
| [open-dropbox-folder.ps1](Scripts/open-dropbox-folder.ps1) | Opens the user's Dropbox folder. [Read more...](Docs/open-dropbox-folder.md)          |
| [open-edge.ps1](Scripts/open-edge.ps1)               | Launches the Edge browser. [Read more...](Docs/open-edge.md)                                |
| [open-email-client.ps1](Scripts/open-browser.ps1)    | Starts the default email client. [Read more...](Docs/open-email-client.md)                  |
| [open-facebook-website.ps1](Scripts/open-facebook-website.ps1)| Opens Facebook's website. [Read more...](Docs/open-facebook-website.md)            |
| [open-file-explorer.ps1](Scripts/open-file-explorer.ps1) | Opens the File Explorer. [Read more...](Docs/open-file-explorer.md)      |
| [open-firefox.ps1](Scripts/open-firefox.ps1)         | Launches the Firefox browser.  [Read more...](Docs/open-firefox.md)            |
| [open-fritz-box.ps1](Scripts/open-fritz-box.ps1)     | Opens FRITZ!Box's web interface. [Read more...](Docs/open-fritz-box.md)          |
| [open-github.ps1](Scripts/open-github.ps1)           | Opens GitHub's website.  [Read more...](Docs/open-github.md)             |
| [open-google-contacts.ps1](Scripts/open-google-contacts.ps1) | Opens Google Contacts.  [Read more...](Docs/open-google-contacts.md)    |
| [open-google-earth.ps1](Scripts/open-google-earth.ps1) | Opens Google Earth.  [Read more...](Docs/open-google-earth.md)       |
| [open-google-mail.ps1](Scripts/open-google-mail.ps1) | Opens Google Mail.  [Read more...](Docs/open-google-mail.md)        |
| [open-google-maps.ps1](Scripts/open-google-maps.ps1) | Opens Google Maps. [Read more...](Docs/open-google-maps.md)        |
| [open-google-news.ps1](Scripts/open-google-news.ps1) | Opens Google News. [Read more...](Docs/open-google-news.md)        |
| [open-google-play.ps1](Scripts/open-google-play.ps1) | Opens Google Play.  [Read more...](Docs/open-google-play.md)        |
| [open-google-search.ps1](Scripts/open-google-search.ps1) | Opens Google Search.   [Read more...](Docs/open-google-search.md)      |
| [open-google-translate.ps1](Scripts/open-google-translate.ps1) | Opens Google Translate. [Read more...](Docs/open-google-translate.md)   |
| [open-home-folder.ps1](Scripts/open-home-folder.ps1) | Opens the user's home folder.  [Read more...](Docs/open-home-folder.md)        |
| [open-music-folder.ps1](Scripts/open-music-folder.ps1)| Opens the user's music folder.  [Read more...](Docs/open-music-folder.md)       |
| [open-netflix.ps1](Scripts/open-netflix.ps1)         | Starts the Netflix app.  [Read more...](Docs/open-netflix.md)            |
| [open-microsoft-store.ps1](Scripts/open-microsoft-store.ps1)| Launches the Microsoft Store app.  [Read more...](Docs/open-microsoft-store.md)    |
| [open-notepad.ps1](Scripts/open-notepad.ps1)         | Starts the Notepad app.  [Read more...](Docs/open-notepad.md)            |
| [open-onedrive-folder.ps1](Scripts/open-onedrive-folder.ps1)| Opens the user's OneDrive folder. [Read more...](Docs/open-onedrive-folder.md)    |
| [open-pictures-folder.ps1](Scripts/open-pictures-folder.ps1) | Opens the user's pictures folder.  [Read more...](Docs/open-pictures-folder.md)    |
| [open-recycle-bin.ps1](Scripts/open-recycle-bin.ps1) | Opens the user's recycle bin folder.  [Read more...](Docs/open-recycle-bin.md)        |
| [open-repos-folder.ps1](Scripts/open-repos-folder.ps1) | Opens the user's Git repositories folder.  [Read more...](Docs/open-repos-folder.md)       |
| [open-snipping-tool.ps1](Scripts/open-snipping-tool.ps1)| Starts the Snipping Tool. [Read more...](Docs/open-snipping-tool.md)      |
| [open-speed-test.ps1](Scripts/open-speed-test.ps1)   | Opens Cloudflare's speed test.  [Read more...](Docs/open-speed-test.md)         |
| [open-spotify.ps1](Scripts/open-spotify.ps1)         | Opens Spotify.  [Read more...](Docs/open-spotify.md)            |
| [open-system-settings.ps1](Scripts/open-system-settings.ps1)| Opens the system settings of Windows.  [Read more...](Docs/open-system-settings.md)    |
| [open-task-manager.ps1](Scripts/open-task-manager.ps1)| Starts the Task Manager.  [Read more...](Docs/open-task-manager.md)       |
| [open-videos-folder.ps1](Scripts/open-videos-folder.ps1)| Opens the user's videos folder. [Read more...](Docs/open-videos-folder.md)      |
| [open-windows-terminal.ps1](Scripts/open-windows-terminal.ps1)| Launches Windows Terminal. [Read more...](Docs/open-windows-terminal.md)   |
| [open-wikipedia-website.ps1](Scripts/open-wikipedia-website.ps1)| Opens Wikipedia's website.  [Read more...](Docs/open-wikipedia-website.md)  |
| [open-youtube-website.ps1](Scripts/open-youtube-website.ps1)| Opens YouTube's website. [Read more...](Docs/open-youtube-website.md)    |
| [remind-me.ps1](Scripts/remind-me.ps1)               | Creates a scheduled task that will display a popup message.          [Read more...](Docs/remind-me.md)               |
| [save-screenshot.ps1](Scripts/save-screenshot.ps1)   | Saves a single screenshot. [Read more...](Docs/save-screenshot.md)         |
| [set-wallpaper.ps1](Scripts/set-wallpaper.ps1)       | Sets the given image as wallpaper. [Read more...](Docs/set-wallpaper.md)           |

📁 Scripts for Files & Folders 
-------------------------------

| Script                                               | Description                                                                                      |
| ---------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| [cd-autostart.ps1](Scripts/cd-autostart.ps1)         | Set the working directory to the user's autostart folder. [Read more...](Docs/cd-autostart.md)        |
| [cd-desktop.ps1](Scripts/cd-desktop.ps1)             | Set the working directory to the user's desktop folder. [Read more...](Docs/cd-desktop.md)          |
| [cd-docs.ps1](Scripts/cd-docs.ps1)                   | Set the working directory to the user's documents folder. [Read more...](Docs/cd-docs.md)             |
| [cd-downloads.ps1](Scripts/cd-downloads.ps1)         | Set the working directory to the user's downloads folder. [Read more...](Docs/cd-downloads.md)        |
| [cd-dropbox.ps1](Scripts/cd-dropbox.ps1)             | Set the working directory to the user's Dropbox folder. [Read more...](Docs/cd-dropbox.md)          |
| [cd-home.ps1](Scripts/cd-home.ps1)                   | Set the working directory to the user's home folder. [Read more...](Docs/cd-home.md)             |
| [cd-music.ps1](Scripts/cd-music.ps1)                 | Set the working directory to the user's music folder. [Read more...](Docs/cd-music.md)            |  
| [cd-onedrive.ps1](Scripts/cd-onedrive.ps1)           | Set the working directory to the user's OneDrive folder. [Read more...](Docs/cd-onedrive.md)         |
| [cd-pics.ps1](Scripts/cd-pics.ps1)                   | Set the working directory to the user's pictures folder. [Read more...](Docs/cd-pics.md)             |
| [cd-recycle-bin.ps1](Scripts/cd-recycle-bin.ps1)     | Set the working directory to the user's recycle bin folder. [Read more...](Docs/cd-recycle-bin.md)      |
| [cd-repos.ps1](Scripts/cd-repos.ps1)                 | Change the working directory to the user's Git repositories folder. [Read more...](Docs/cd-repos.md)            |
| [cd-root.ps1](Scripts/cd-root.ps1)                   | Set the working directory to the root directory. [Read more...](Docs/cd-root.md)             |
| [cd-scripts.ps1](Scripts/cd-scripts.ps1)             | Set the working directory to the PowerShell Scripts folder. [Read more...](Docs/cd-scripts.md)          |
| [cd-ssh.ps1](Scripts/cd-ssh.ps1)                     | Set the working directory to the user's SSH folder. [Read more...](Docs/cd-ssh.md)              |
| [cd-up.ps1](Scripts/cd-up.ps1)                       | Set the working directory to one directory level up. [Read more...](Docs/cd-up.md)               | 
| [cd-up2.ps1](Scripts/cd-up2.ps1)                     | Set the working directory to two directory levels up. [Read more...](Docs/cd-up2.md)              |
| [cd-up3.ps1](Scripts/cd-up3.ps1)                     | Set the working directory to three directory levels up. [Read more...](Docs/cd-up3.md)              |
| [cd-up4.ps1](Scripts/cd-up4.ps1)                     | Set the working directory to four directory levels up. [Read more...](Docs/cd-up4.md)              |
| [cd-videos.ps1](Scripts/cd-videos.ps1)               | Set the working directory to the user's videos folder. [Read more...](Docs/cd-videos.md)           |
| [check-symlinks.ps1](Scripts/check-symlinks.ps1)     | Checks every symlink in a directory tree. [Read more...](Docs/check-symlinks.md)      |
| [check-xml-file.ps1](Scripts/check-xml-file.ps1)     | Checks the given XML file for validity. [Read more...](Docs/check-xml-file.md)      |
| [clear-recycle-bin.ps1](Scripts/clear-recycle-bin.ps1) | Removes the content of the recycle bin folder (can not be undo!). [Read more...](Docs/clear-recycle-bin.md)   |
| [copy-photos-sorted.ps1](Scripts/copy-photos-sorted.ps1) | Copy image files sorted by year and month. [Read more...](Docs/copy-photos-sorted.md)  |
| [decrypt-file.ps1](Scripts/decrypt-file.ps1)         | Decrypts the given file. [Read more...](Docs/decrypt-file.md)        |
| [download-dir.ps1](Scripts/download-dir.ps1)         | Downloads a directory tree from the given URL. [Read more...](Docs/download-dir.md)        |
| [download-file.ps1](Scripts/download-file.ps1)       | Downloads a file from the given URL. [Read more...](Docs/download-file.md)       |
| [edit.ps1](Scripts/edit.ps1)                         | Edits the given file with the built-in text editor. [Read more...](Docs/edit.md)                |
| [encrypt-file.ps1](Scripts/encrypt-file.ps1)         | Encrypts the given file. [Read more...](Docs/encrypt-file.md)        |
| [get-md5.ps1](Scripts/get-md5.ps1)                   | Prints the MD5 checksum of the given file. [Read more...](Docs/get-md5.md)             |
| [get-sha1.ps1](Scripts/get-sha1.ps1)                 | Prints the SHA1 checksum of the given file. [Read more...](Docs/get-sha1.md)            |
| [get-sha256.ps1](Scripts/get-sha256.ps1)             | Prints the SHA256 checksum of the given file. [Read more...](Docs/get-sha256.md)          |
| [inspect-exe.ps1](Scripts/inspect-exe.ps1)           | Prints basic information of the given executable file. [Read more...](Docs/inspect-exe.md)         |
| [list-dir-tree.ps1](Scripts/list-dir-tree.ps1)       | Lists the directory tree content. [Read more...](Docs/list-dir-treep.md)      |
| [list-empty-dirs.ps1](Scripts/list-empty-dirs.ps1)   | Lists empty subfolders within the given directory tree. [Read more...](Docs/list-empty-dirs.md)     |
| [list-empty-files.ps1](Scripts/list-empty-files.ps1) | Lists empty files within the given directory tree. [Read more...](Docs/list-empty-files.md)    |
| [list-files.ps1](Scripts/list-files.ps1)             | Lists all files in the given folder and also in every subfolder. [Read more...](Docs/list-files.md)          |
| [list-folder.ps1](Scripts/list-folder.ps1)           | Lists the folder content. [Read more...](Docs/list-folder.md)         |
| [list-hidden-files.ps1](Scripts/list-hidden-files.ps1) | Lists hidden files within the given directory tree. [Read more...](Docs/list-hidden-files.md)   |
| [list-recycle-bin.ps1](Scripts/list-recycle-bin.ps1) | Lists the content of the recycle bin folder. [Read more...](Docs/list-recycle-bin.md)    |
| [list-unused-files.ps1](Scripts/list-unused-files.ps1) | Lists unused files in a directory tree. [Read more...](Docs/list-unused-files.md)   |
| [list-workdir.ps1](Scripts/list-workdir.ps1)         | Lists the current working directory. [Read more...](Docs/list-workdir.md)        |
| [make-install.ps1](Scripts/make-install.ps1)         | Installs built executables and libs to the installation directory. [Read more...](Docs/make-install.md)        |
| [new-shortcut.ps1](Scripts/new-shortcut.ps1)         | Creates a new shortcut file. [Read more...](Docs/new-shortcut.md)        |
| [new-symlink.ps1](Scripts/new-symlink.ps1)           | Creates a new symbolic link file. [Read more...](Docs/new-symlink.md)         |
| [new-zipfile.ps1](Scripts/new-zipfile.ps1)           | Creates a new .zip file from a directory. [Read more...](Docs/new-zipfile.md)         |
| [publish-to-ipfs.ps1](Scripts/publish-to-ipfs.ps1)   | Publishes the given files or directory to IPFS. [Read more...](Docs/publish-to-ipfs.md)     |
| [remove-empty-dirs.ps1](Scripts/remove-empty-dirs.ps1) | Removes empty subfolders within the given directory tree. [Read more...](Docs/remove-empty-dirs.md)   |
| [replace-in-files.ps1](Scripts/replace-in-files.ps1) | Search and replace a pattern in the given files by the replacement. [Read more...](Docs/replace-in-files.md)    |
| [search-filename.ps1](Scripts/search-filename.ps1)   | Searches the directory tree for filenames by given pattern. [Read more...](Docs/search-filename.md)     |
| [search-files.ps1](Scripts/search-files.ps1)         | Searches the given pattern in the given files. [Read more...](Docs/search-files.md)        |
| [upload-file.ps1](Scripts/upload-file.ps1)           | Uploads the local file to the given FTP server. [Read more...](Docs/upload-file.md)         |

♻️ Scripts to Convert Files
---------------------------

| Script                                                 | Description                                                                                         |
| ------------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| [convert-csv2txt.ps1](Scripts/convert-csv2txt.ps1)     | Converts a .CSV file to a text file. [Read more...](Docs/convert-csv2txt.md)                              |
| [convert-mysql2csv.ps1](Scripts/convert-mysql2csv.ps1) | Converts a MySQL database table to a .CSV file. [Read more...](Docs/convert-mysql2csv.md)                 |
| [convert-ps2bat.ps1](Scripts/convert-ps2bat.ps1)       | Converts a PowerShell script to a Batch script. [Read more...](Docs/convert-ps2bat.md)                    |
| [convert-ps2md.ps1](Scripts/convert-ps2md.ps1)         | Converts the comment-based help of a PowerShell script to Markdown. [Read more...](Docs/convert-ps2md.md) |
| [convert-sql2csv.ps1](Scripts/convert-sql2csv.ps1)     | Converts a SQL database table to a .CSV file. [Read more...](Docs/convert-sql2csv.md)                     |
| [convert-txt2wav.ps1](Scripts/convert-txt2wav.ps1)     | Converts text to a .WAV audio file. [Read more...](Docs/convert-txt2wav.md)                               |
| [export-to-manuals.ps1](Scripts/export-to-manuals.ps1) | Exports all scripts as manuals. [Read more...](Docs/export-to-manuals.md)                                 |


📝 Scripts for Git
-------------------

| Script                                               | Description                                                                                       |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| [build-repo.ps1](Scripts/build-repo.ps1)             | Builds a Git repository. [Read more...](Docs/build-repo.md)                                       |
| [build-repos.ps1](Scripts/build-repos.ps1)           | Builds all Git repositories in a folder. [Read more...](Docs/build-repos.md)                      |
| [check-repo.ps1](Scripts/check-repo.ps1)             | Checks a Git repository. [Read more...](Docs/check-repo.md)                                       |
| [clean-repo.ps1](Scripts/clean-repo.ps1)             | Cleans a Git repository from untracked files. [Read more...](Docs/clean-repo.md)                  |
| [clean-repos.ps1](Scripts/clean-repos.ps1)           | Cleans all Git repositories in a folder from untracked files. [Read more...](Docs/clean-repos.md) |
| [clone-repos.ps1](Scripts/clone-repos.ps1)           | Clones well-known Git repositories. [Read more...](Docs/clone-repos.md)                           |
| [configure-git.ps1](Scripts/configure-git.ps1)       | Sets up the Git user configuration. [Read more...](Docs/configure-git.md)                         |
| [fetch-repo.ps1](Scripts/fetch-repo.ps1)             | Fetches updates for a Git repository. [Read more...](Docs/fetch-repo.md)                          |
| [fetch-repos.ps1](Scripts/fetch-repos.ps1)           | Fetches updates for all Git repositories in a folder. [Read more...](Docs/fetch-repos.md)         |
| [list-branches.ps1](Scripts/list-branches.ps1)       | Lists all branches in a Git repository. [Read more...](Docs/list-branches.md)                     |
| [list-commits.ps1](Scripts/list-commits.ps1)         | Lists all commits in a Git repository. [Read more...](Docs/list-commits.md)                       |
| [list-latest-tag.ps1](Scripts/list-latest-tag.ps1)   | Lists the latest tag on the current branch in a Git repository. [Read more...](Docs/list-latest-tag.md) |
| [list-latest-tags.ps1](Scripts/list-latest-tags.ps1) | Lists the latests tags in all Git repositories under a directory. [Read more...](Docs/list-latest-tags.md) |
| [list-repos.ps1](Scripts/list-repos.ps1)             | Lists the Git repositories in a folder. [Read more...](Docs/list-repos.md)                        |
| [list-submodules.ps1](Scripts/list-submodules.ps1)   | Lists the submodules in a Git repository. [Read more...](Docs/list-submodules.md)                 |
| [list-tags.ps1](Scripts/list-tags.ps1)               | Lists all tags in a Git repository. [Read more...](Docs/list-tags.md)                             |
| [new-branch.ps1](Scripts/new-branch.ps1)             | Creates a new branch in a Git repository. [Read more...](Docs/new-branch.md)                      |
| [new-tag.ps1](Scripts/new-tag.ps1)                   | Creates a new tag in a Git repository. [Read more...](Docs/new-tag.md)                            |
| [pick-commit.ps1](Scripts/pick-commit.ps1)           | Cherry-picks a Git commit into multiple branches. [Read more...](Docs/pick-commit.md)             |
| [pull-repo.ps1](Scripts/pull-repo.ps1)               | Pulls updates for a Git repository. [Read more...](Docs/pull-repo.md)                             |
| [pull-repos.ps1](Scripts/pull-repos.ps1)             | Pulls updates for all Git repositories in a folder. [Read more...](Docs/pull-repos.md)            |
| [remove-tag.ps1](Scripts/remove-tag.ps1)             | Removes a tag in a Git repository. [Read more...](Docs/remove-tag.md)                             |
| [switch-branch.ps1](Scripts/switch-branch.ps1)       | Switches the branch in a Git repository. [Read more...](Docs/switch-branch.md)                    |
| [sync-repo.ps1](Scripts/sync-repo.ps1)               | Synchronizes a Git repository by pull & push. [Read more...](Docs/sync-repo.md)                   |

🔎 Scripts for PowerShell 
------------------------

| Script                                                 | Description                                                                                            |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| [daily-tasks.sh](Scripts/daily-tasks.sh)               | Execute PowerShell scripts automatically as daily tasks (Linux only). [Read more...](Docs/daily-tasks.sh.md) |
| [introduce-powershell.ps1](Scripts/introduce-powershell.ps1) | Introduces PowerShell to new users. [Read more...](Docs/introduce-powershell.md)                 |
| [list-aliases.ps1](Scripts/list-aliases.ps1)           | Lists all PowerShell aliases. [Read more...](Docs/list-aliases.md)                                     |
| [list-automatic-variables.ps1](Scripts/list-automatic-variables.ps1) | Lists the automatic variables of PowerShell. [Read more...](Docs/list-automatic-variables.md)|
| [list-cheat-sheet.ps1](Scripts/list-cheat-sheet.ps1)   | Lists the PowerShell cheat sheet. [Read more...](Docs/list-cheat-sheet.md)                             |
| [list-cmdlets.ps1](Scripts/list-cmdlets.ps1)           | Lists the PowerShell cmdlets. [Read more...](Docs/list-cmdlets.md)                                     |
| [list-console-colors.ps1](Scripts/list-console-colors.ps1) | Lists all console colors. [Read more...](Docs/list-console-colors.md)                              |
| [list-modules.ps1](Scripts/list-modules.ps1)           | Lists the PowerShell modules. [Read more...](Docs/list-modules.md)                                     |
| [list-profiles.ps1](Scripts/list-profiles.ps1)         | Lists your PowerShell profiles. [Read more...](Docs/list-profiles.md)                                  |
| [list-scripts.ps1](Scripts/list-scripts.ps1)           | Lists all PowerShell scripts in this repository. [Read more...](Docs/list-scripts.md)                  |
| [new-script.ps1](Scripts/new-script.ps1)               | Creates a new PowerShell script. [Read more...](Docs/new-script.md)                                    |
| [set-profile.ps1](Scripts/set-profile.ps1)             | Updates your PowerShell user profile. [Read more...](Docs/set-profile.md)                              |

🛒 Various PowerShell Scripts 
------------------------------

| Script                                               | Description                                                                                         |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [add-memo.ps1](Scripts/add-memo.ps1)                 | Adds the given memo text to $HOME/Memos.csv.                        [Read more...](Docs/add-memo.md)                |
| [check-ipv4-address.ps1](Scripts/check-ipv4-address.ps1)| Checks the given IPv4 address for validity.                       [Read more...](Docs/check-ipv4-address.md)      |
| [check-ipv6-address.ps1](Scripts/check-ipv6-address.ps1)| Checks the given IPv6 address for validity.                       [Read more...](Docs/check-ipv6-address.md)      |
| [check-mac-address.ps1](Scripts/check-mac-address.ps1)| Checks the given MAC address for validity.                          [Read more...](Docs/check-mac-address.md)       |
| [check-subnet-mask.ps1](Scripts/check-subnet-mask.ps1)| Checks the given subnet mask for validity.                          [Read more...](Docs/check-subnet-mask.md)       |
| [check-weather.ps1](Scripts/check-weather.ps1)       | Checks the current weather for critical values.                      [Read more...](Docs/check-weather.md)           |
| [display-time.ps1](Scripts/display-time.ps1)         | Displays the current time for 10 seconds by default.                 [Read more...](Docs/display-time.md)            |
| [list-anagrams.ps1](Scripts/list-anagrams.ps1)       | Lists all anagrams of the given word.                                [Read more...](Docs/list-anagrams.md)           |
| [list-city-weather.ps1](Scripts/list-city-weather.ps1)| Lists the current weather of cities worldwide (west to east).       [Read more...](Docs/list-city-weather.md)       |
| [list-countries.ps1](Scripts/list-countries.ps1)     | Lists details of all countries.                                      [Read more...](Docs/list-countries.md)          |
| [list-credits.ps1](Scripts/list-credits.ps1)         | Shows the credits.                                                   [Read more...](Docs/list-credits.md)            |
| [list-crypto-rates.ps1](Scripts/list-crypto-rates.ps1)| Lists the current crypto exchange rates.                            [Read more...](Docs/list-crypto-rates.md)       |
| [list-environment-variables.ps1](Scripts/list-environment-variables.ps1)| Lists all environment variables.                  [Read more...](Docs/list-environment-variables.md)|
| [list-emojis.ps1](Scripts/list-emojis.ps1)           | Lists the emojis of Unicode 13.0.                                    [Read more...](Docs/list-emojis.md)             |
| [list-fritzbox-calls.ps1](Scripts/list-fritzbox-calls.ps1)| Lists the FRITZ!Box calls.                                      [Read more...](Docs/list-fritzbox-calls.md)     |
| [list-fritzbox-devices.ps1](Scripts/list-fritzbox-devices.ps1)| Lists FRITZ!Box's known devices.                            [Read more...](Docs/list-fritzbox-devices.md)   |
| [list-earthquakes.ps1](Scripts/list-earthquakes.ps1) | Lists earthquakes with magnitude >= 6.0 for the last 30 days.        [Read more...](Docs/list-earthquakes.md)        |
| [list-exchange-rates.ps1](Scripts/list-exchange-rates.ps1)| Lists the current exchange rates for the given currency.        [Read more...](Docs/list-exchange-rates.md)     |
| [list-memos.ps1](Scripts/list-memos.ps1)             | Lists the memos at $HOME/Memos.csv.                                  [Read more...](Docs/list-memos.md)              |
| [list-mysql-tables.ps1](Scripts/list-mysql-tables.ps1)| Lists the MySQL server tables.                                      [Read more...](Docs/list-mysql-tables.md)       |
| [list-news.ps1](Scripts/list-news.ps1)               | Lists the latest news.                                               [Read more...](Docs/list-news.md)               |
| [list-os-releases.ps1](Scripts/list-os-releases.ps1) | Lists operating system releases and download URL.                    [Read more...](Docs/list-os-releases.md)        |
| [list-os-updates.ps1](Scripts/list-os-updates.ps1)   | Lists operating system updates.                                      [Read more...](Docs/list-os-updates.md)         |
| [list-passwords.ps1](Scripts/list-passwords.ps1)     | Prints a list of random passwords.                                   [Read more...](Docs/list-passwords.md)          |
| [list-pins.ps1](Scripts/list-pins.ps1)               | Prints a list of random PIN's.                                       [Read more...](Docs/list-pins.md)               |
| [list-sql-tables.ps1](Scripts/list-sql-tables.ps1)   | Lists the SQL server tables.                                         [Read more...](Docs/list-sql-tables.md)         |
| [list-tiobe-index.ps1](Scripts/list-tiobe-index.ps1) | Lists the TIOBE index of top programming languages.                  [Read more...](Docs/list-tiobe-index.md)        |
| [list-weather.ps1](Scripts/list-weather.ps1)         | Lists the hourly weather.                                            [Read more...](Docs/list-weather.md)            |
| [locate-city.ps1](Scripts/locate-city.ps1)           | Prints the geographic location of the given city.                    [Read more...](Docs/locate-city.md)             |
| [locate-ipaddress.ps1](Scripts/locate-ipaddress.ps1) | Prints the geographic location of the given IP address.              [Read more...](Docs/locate-ipaddress.md)        |
| [locate-zip-code.ps1](Scripts/locate-zip-code.ps1)   | Prints the geographic location of the given zip-code.                [Read more...](Docs/locate-zip-code.md)         |
| [moon.ps1](Scripts/moon.ps1)                         | Prints the current moon phase.                                       [Read more...](Docs/moon.md)                    |
| [new-qrcode.ps1](Scripts/new-qrcode.ps1)             | Generates a new QR code image file.                                  [Read more...](Docs/new-qrcode.md)              |
| [reboot-fritzbox.ps1](Scripts/reboot-fritzbox.ps1)   | Reboots the FRITZ!box device.                                        [Read more...](Docs/reboot-fritzbox.md)         |
| [scan-ports.ps1](Scripts/scan-ports.ps1)             | Scans the network for open/closed ports.                             [Read more...](Docs/scan-ports.md)              |
| [send-email.ps1](Scripts/send-email.ps1)             | Sends an email message.                                              [Read more...](Docs/send-email.md)              |
| [send-tcp.ps1](Scripts/send-udp.ps1)                 | Sends a TCP message to the given IP address and port.                [Read more...](Docs/send-tcp.md)                |
| [send-udp.ps1](Scripts/send-udp.ps1)                 | Sends a UDP datagram message to the given IP address and port.       [Read more...](Docs/send-udp.md)                |
| [set-timer.ps1](Scripts/set-timer.ps1)               | Sets a timer for a countdown.                                        [Read more...](Docs/set-timer.md)               |
| [simulate-presence.ps1](Scripts/simulate-presence.ps1)| Simulates the human presence against burglars.                      [Read more...](Docs/simulate-presence.md)       |
| [start-calibre-server.ps1](Scripts/start-calibre-server.ps1)| Starts a local Calibre server.                                [Read more...](Docs/start-calibre-server.md)    |
| [start-ipfs-server.ps1](Scripts/start-ipfs-server.ps1)| Starts a local IPFS server.                                         [Read more...](Docs/start-ipfs-server.md)       |
| [switch-shelly1.ps1](Scripts/switch-shelly1.ps1)     | Switches a Shelly1 device in the local network.                      [Read more...](Docs/switch-shelly1.md)          |
| [translate-file.ps1](Scripts/translate-file.ps1)     | Translates the given text file into other languages.                 [Read more...](Docs/translate-file.md)          |
| [translate-files.ps1](Scripts/translate-files.ps1)   | Translates the given text files into any supported language.         [Read more...](Docs/translate-files.md)         |
| [translate-text.ps1](Scripts/translate-text.ps1)     | Translates the given text in English into other languages.           [Read more...](Docs/translate-text.md)          |
| [weather.ps1](Scripts/weather.ps1)                   | Prints the current weather forecast.                                 [Read more...](Docs/weather.md)                 |
| [weather-report.ps1](Scripts/weather-report.ps1)     | Prints the local weather report.                                     [Read more...](Docs/weather-report.md)          |
| [what-is.ps1](Scripts/what-is.ps1)                   | Prints a description of the given abbreviation.                      [Read more...](Docs/what-is.md)                 |
| [write-animated.ps1](Scripts/write-animated.ps1)     | Writes animated text.                                                [Read more...](Docs/write-animated.md)          |
| [write-big.ps1](Scripts/write-big.ps1)               | Writes the given text in big letters.                                [Read more...](Docs/write-big.md)               |
| [write-blue.ps1](Scripts/write-blue.ps1)             | Writes the given text in a blue foreground color.                    [Read more...](Docs/write-blue.md)              |
| [write-braille.ps1](Scripts/write-braille.ps1)       | Writes the given text in Braille.                                    [Read more...](Docs/write-braille.md)           |
| [write-calendar.ps1](Scripts/write-calendar.ps1)     | Writes the calendar (month of year).                                 [Read more...](Docs/write-calendar.md)          |
| [write-green.ps1](Scripts/write-green.ps1)           | Writes the given text in a green foreground color.                   [Read more...](Docs/write-green.md)             |
| [write-joke.ps1](Scripts/write-joke.ps1)             | Writes a random Juck Norris joke.                                    [Read more...](Docs/write-joke.md)              |
| [write-lowercase.ps1](Scripts/write-lowercase.ps1)   | Writes the given text in lowercase letters.                          [Read more...](Docs/write-lowercase.md)         |
| [write-marquee.ps1](Scripts/write-marquee.ps1)       | Writes the given text as marquee.                                    [Read more...](Docs/write-marquee.md)           |
| [write-morse-code.ps1](Scripts/write-morse-code.ps1) | Writes the given text in Morse code.                                 [Read more...](Docs/write-morse-code.md)        |
| [write-motd.ps1](Scripts/write-motd.ps1)             | Writes the message of the day (MOTD).                                [Read more...](Docs/write-motd.md)              |
| [write-quote.ps1](Scripts/write-quote.ps1)           | Writes a random quote.                                               [Read more...](Docs/write-quote.md)             |
| [write-red.ps1](Scripts/write-red.ps1)               | Writes the given text in a red foreground color.                     [Read more...](Docs/write-red.md)               |
| [write-rot13.ps1](Scripts/write-rot13.ps1)           | Encodes or decodes the given text with ROT13.                        [Read more...](Docs/write-rot13.md)             |
| [write-typewriter.ps1](Scripts/write-typewriter.ps1) | Writes the given text with the typewriter effect.                    [Read more...](Docs/write-typewriter.md)        |
| [write-uppercase.ps1](Scripts/write-uppercase.ps1)   | Writes the given text in uppercase letters.                          [Read more...](Docs/write-uppercase.md)         |
| [write-vertical.ps1](Scripts/write-vertical.ps1)     | Writes the given text in vertical direction.                         [Read more...](Docs/write-vertical.md)          |

📧 Feedback
------------
Send your email feedback to: `markus.fleschutz [at] gmail.com`

🤝 License & Copyright
-----------------------
This open source project is licensed under the CC0-1.0 license. All trademarks are the property of their respective owners.
