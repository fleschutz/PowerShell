Executing PowerShell Scripts by Voice
=====================================

Installation
------------
1. Download and install *Serenade* from https://serenade.ai/.
2. Download and install the *PowerShell Scripts*, then set the search path to it.
3. Execute once: `./export-to-serenade.ps1 computer` - this creates a custom JavaScript file at `$HOME/.serenade/scripts/PowerShell.js` using the wake word 'computer'.
4. Launch *Serenade* and click the Pause button to enable Listening mode.
5. Launch *Windows Terminal* and click into the window.
6. Say: `Computer, open calculator` - this launches the calculator application by executing the PowerShell script `open-calculator.ps1`.

More voice commands are:

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


Conversation
------------
1. *[wake word], good morning.*
2. *[wake word], good evening.*
3. *[wake word], good night.*
4. *[wake word], how are you?*
5. *[wake word], thank you.*
