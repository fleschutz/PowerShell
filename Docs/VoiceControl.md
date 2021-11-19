Executing PowerShell Scripts by Voice
=====================================

Installation
------------
1. Download and install *Serenade* from https://serenade.ai/.
2. Download and install the *PowerShell Scripts*, then set the search path to it.
3. Execute the PowerShell script: `./export-to-serenade.ps1 computer` - this creates a custom JavaScript file at `$HOME/.serenade/scripts/PowerShell.js` using the wake word 'computer'.

Usage
-----
1. Launch *Serenade* and click the Pause button to enable Listening mode.
2. Launch *Windows Terminal* and click into the window.
3. Say: `Computer, open calculator` - this executes the PowerShell script `open-calculator.ps1` to launch the calculator application.

More supported voice commands are:

[wake word], open NAME
----------------------
* this launches the given application.
* replace NAME by: "calculator", "Google Chrome", "Microsoft Edge", "Mozilla Firefox", "Netflix".
* afterward, use *[wake word], close NAME* to close the application.


[wake word], open NAME drive
----------------------------
* this launches the File Explorer with the given drive.
* replace NAME by: "C:", "D:", "E:", "F:", or "M:".
* afterward, use *[wake word], close file explorer* to close the file explorer.


[wake word], open NAME folder
-----------------------------
* this launches the File Explorer with the given folder.
* replace NAME by: "downloads", "dropbox", "home", "music", "pictures", "repos", or "videos".
* afterward, use *[wake word], close file explorer* to close the file explorer.


[wake word], open NAME website
------------------------------
* this launches the default browser with the given website.
* replace NAME by: "Amazon", "Baidu", "BBC", "CDC", "CIA", "CNN", "eBay", "Facebook", "FBI", "Instagram", "Microsoft", "NASA", "NBC", "Pinterest", "Pixabay", "Slashdot", "Tesla", "Twitter", "UFA", "Unsplash", "Walmart", "WhatsApp", "White House", "Wikipedia", "Wired", or "Yahoo".


[wake word], show NAME city
---------------------------
* this launches the default browser with Google Maps showing the given city.
* replace NAME by: "Atlanta", "Barcelona", "Berlin", "Boston", "Cairo", "Cape Town", "Chicago", "Dallas", "Dubai", "Dublin", "Frankfurt", "Hamburg", "Hong Kong", "Jerusalem", "Las Vegas", "Lissabon", "London", "Los Angeles", "Madrid", "Miami", "Moscow", "Munich", "New York", "Paris", Rome", "San Francisco", "Seattle", "Singapore", "Sydney", "Tokyo", "Toronto", or "Washington".


[wake word], play radio NAME
----------------------------
* this launches the default browser and tunes into an internet radio station stream.
* replace NAME: by "Arabella", "Bob", "Galaxy", "7", "Gong", "Kiss Kiss", "N-JOY", ...


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
