Executing PowerShell Scripts by Voice
=====================================


Installation
------------
1. Download and install *Serenade* from https://serenade.ai/.
2. Download and install the *PowerShell Scripts*, then set the search path to it.
3. Execute: `./export-to-serenade.ps1 computer` in the *PowerShell Scripts* - this creates a custom JavaScript file at `$HOME/.serenade/scripts/PowerShell.js` using the wake word 'computer'. Recommended wake words with a high detection rate are: "Alexa", "Computer", "Siri" and "Windows".


Usage
-----
1. Launch *Serenade* and click the Pause button to enable Listening mode.
2. Launch *Windows Terminal* and click into the window.
3. Say: `Computer, open calculator app` - this executes the PowerShell script `open-calculator-app.ps1` to launch the calculator application.

More supported voice commands are:


[wake word], open NAME browser
------------------------------
* this launches the given Web browser.
* replace NAME by: "Chrome", "Edge", or "Firefox".
* when finished use: *[wake word], close NAME browser* to stop the Web browser.


[wake word], open NAME app
--------------------------
* this launches the given application.
* replace NAME by: "Calculator", "Netflix", "Spotify", "Thunderbird", or "Visual Studio".
* when finished use: *[wake word], close NAME app* to stop the application.


[wake word], open NAME drive
----------------------------
* this launches the File Explorer with the given drive.
* replace NAME by: "C:", "D:", "E:", "F:", or "M:".
* when finished use: *[wake word], close file explorer* to stop the File Explorer.


[wake word], open NAME folder
-----------------------------
* this launches the File Explorer with the given folder.
* replace NAME by: "downloads", "dropbox", "home", "music", "pictures", "repos", or "videos".
* when finished use: *[wake word], close file explorer* to stop the File Explorer.


[wake word], open NAME settings
-------------------------------
* this launches the corresponding Windows settings.
* replace NAME by: "activation", "apps", "background", "backup", "bluetooth", "color", "date", "default apps", "developer", "display", "ethernet", "lockscreen", "maps", "printer", "proxy", "recovery", "speech", "start", "system", "taskbar", "themes", "time", "update", "usb", "vpn", or "wifi". Use "system" as top level settings.
* when finished use: *[wake word], close system settings* to stop the Windows settings.


[wake word], open NAME website
------------------------------
* this launches the default Web browser with the given website.
* replace NAME by: "Amazon", "Baidu", "BBC", "CDC", "CIA", "CNN", "eBay", "Facebook", "FBI", "GitHub", "Instagram", "Microsoft", "NASA", "NBC", "Pinterest", "Pixabay", "Slashdot", "Tesla", "Twitter", "UFA", "Unsplash", "Walmart", "WhatsApp", "White House", "Wikipedia", "Wired", or "Yahoo".
* when finished see "close NAME browser" to stop the Web browser.


[wake word], show NAME city
---------------------------
* this launches the default Web browser with Google Maps showing the given city.
* replace NAME by: "Atlanta", "Barcelona", "Berlin", "Boston", "Cairo", "Cape Town", "Chicago", "Dallas", "Dubai", "Dublin", "Frankfurt", "Hamburg", "Hong Kong", "Jerusalem", "Las Vegas", "Lissabon", "London", "Los Angeles", "Madrid", "Miami", "Moscow", "Munich", "New York", "Paris", Rome", "San Francisco", "Seattle", "Singapore", "Sydney", "Tokyo", "Toronto", or "Washington".
* when finished see "close NAME browser" to stop the Web browser.


[wake word], play radio NAME
----------------------------
* this launches the default Web browser and tunes into an internet radio station stream.
* replace NAME: by "Arabella", "Bob", "Galaxy", "7", "Gong", "Kiss Kiss", "N-JOY", ...
* when finished see "close NAME browser" to stop the Web browser.


[wake word], play NAME sound
----------------------------
* this starts a playback of the given audio sound.
* replace NAME: by "bee", "beep", "cat", "cow", "dog", "donkey", "elephant", "elk", "frog", "goat", "gorilla", "horse", "lion", "parrot", "pig", "rattlesnake", "vulture", or "wolf".


Audio
-----
* *[wake word], mute audio.*
* *[wake word], unmute audio.*
* *[wake word], turn volume up.*
* *[wake word], turn volume down.*


Conversation
------------
* *[wake word], good morning.*
* *[wake word], good evening.*
* *[wake word], good night.*
* *[wake word], how are you?*
* *[wake word], thank you.*
