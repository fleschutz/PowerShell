Executing PowerShell Scripts by Voice
=====================================
Build your own voice assistant by voice recognition and response (VRR). It's so comfortable and so much fun, just give it a try 😊


🔧 Installation
--------------
1. Download and install *Serenade* from https://serenade.ai/ (Serenade is freely available for Linux, MacOS, and Windows).
2. Download and install the *PowerShell Scripts*, allow the script execution and set the search path to it (see the [FAQ page](FAQ.md) for details).
3. Select your personal wake word. Recommended wake words with a high recognition rate are: *"Alexa"*, *"Bixby"*, *"Computer"*, *"James"*, *"Jarvis"*, or *"Windows"*. In the following the wake word *"Computer"* is used.
4. Execute: `./export-to-serenade.ps1 Computer` in the *PowerShell Scripts*, this creates a custom JavaScript file at `$HOME/.serenade/scripts/PowerShell.js` using the wake word 'Computer'. 


🗣 Usage
-------
1. Launch *Serenade* and click into the circle to enable Listening mode.
2. Launch *Windows Terminal* and click into the window.
3. Speak into the microphone: **"*Computer, open calculator*"** - this executes the PowerShell script `open-calculator.ps1` and this script launches the calculator application.

More supported voice commands are:

*"Computer, [greeting]."*
-------------------------
Greets the computer, just replace [greeting] by: `good evening`, `good morning`, `good night`, `happy christmas`, `happy easter`, `happy father's day`, `happy halloween`, `happy hanukkah`, `happy holidays`, `happy kwanzaa`, `happy mother's day`, `happy new year`, `happy ramadan`, `happy St. Patrick's day`, `happy thanksgiving`, `happy valentine's day`, `hello`, `hi`, `how are you?`, `how do you do?`, `merry christmas`, or `say hello`.

*"Computer, open [app]."*
------------------------
Launches the given application, replace [app] by: `3D-Viewer`, `Calculator`,  `Chrome`, `Edge`, `Firefox`, `Git Extensions`, `Magnifier`, `Microsoft Paint`, `Microsoft Store`, `Netflix`, `Notepad`, `OBS Studio`, `Outlook`, `Paint 3D`, `Spotify`, `Thunderbird`, `Visual Studio`, or `Windows Terminal`.

When finished say: *"Computer, close [app]"* to close the application.


*"Computer, check [item]."*
--------------------------
Lets the computer check something, replace [item] by: `Bitcoin rate`, `Christmas`, `CPU`, `date`, `dawn`, `day`, `DNS`, `drives`, `dusk`, `Easter Sunday`, `Earth` (fun), `Ether rate`, `headlines`, `Independence Day`, `ISS position`, `midnight`, `moon phase`, `month`, `New Year`, `noon`, `operating system`, `ping`, `Santa`, `sunrise`, `sunset`, `swap space`, `tea time`, `Tether rate`, `time`, `time zone`, `up-time`, `VPN`, `weather`, `week`, `wind`, `year`, or `zenith`.


*"Computer, open [letter] drive."*
-------------------------------
Launches the File Explorer with the given drive - replace [letter] by: `C:`, `D:`, `E:`, `F:`, `G:`, or `M:`.

When finished say: *"Computer, close file explorer"* to close the File Explorer.


*"Computer, open [name] folder."*
--------------------------------
Launches the File Explorer with the given folder - replace [name] by: `apps`, `autostart`, `desktop`, `documents`, `downloads`, `Dropbox`, `home`, `music`, `OneDrive`, `pictures`, `recycle bin`, `repos`, `temporary`, or `videos`.

When finished say: *"Computer, close file explorer"* to close the File Explorer.


*"Computer, open [name] website."*
---------------------------------
Launches the default Web browser with the given website - replace [name] by: `Amazon`, `Apple`, `Baidu`, `BBC`, `Bing`, `BitBucket`, `CDC`, `CIA`, `CNN`, `Discord`, `DistroWatch`, `Dropbox`, `eBay`, `Facebook`, `FBI`, `Flipboard`, `FourSquare`, `FRITZ!Box`, `FRITZ!Repeater`, `GitHub`, `GliderTracker`, `HolidayCheck`, `HRworks`, `Instagram`, `IPFS`, `Microsoft`, `NASA`, `NBC`, `Netflix`, `Notepad`, `Outdoor Active`, `PayPal`, `Pinterest`, `Pixabay`, `Plex`, `Serenade`, `Slashdot`, `Snap Store`, `Starbucks`, `Tesla`, `TikTok`, `Toggl`, `Topo Map`, `Twitter`,  `UFA`, `Unsplash`, `Walmart`, `WhatsApp`, `White House`, `Windy`, `Wikipedia`, `Wired`, `Wolfram Alpha`, `World News`, `Yahoo`, or `YouTube`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, show [name] city."*
------------------------------
Launches the default Web browser with Google Maps at the given city - replace [NAME] by: `Atlanta`, `Barcelona`, `Berlin`, `Boston`, `Cairo`, `Calgary`, `Cape Town`, `Chicago`, `Dallas`, `Denver`, `Dubai`, `Dublin`, `Frankfurt`, `Hamburg`, `Hong Kong`, `Honolulu`, `Jerusalem`, `Kansas`, `Las Vegas`, `Lisbon`, `London`, `Los Angeles`, `Madrid`, `Mexico`, `Miami`, `Montreal`, `Moscow`, `Munich`, `New York`, `Panama`, `Paris`, `Rome`, `San Francisco`, `Seattle`, `Singapore`, `Sydney`, `Tokyo`, `Toronto`, `Tunis`, `Vienna`, `Washington`, or `Zurich`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, play [genre] music."*
-------------------------------
Launches the default Web browser and plays the given music genre - replace [genre] by: `blues`, `classical`, `country`, `dance`, `folk`, `indie`, `jazz`, `metal`, `pop`,`RnB`, or `rock`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, play radio [station]."*
-------------------------------
Launches the default Web browser and tunes into an internet radio station - replace [station] by: `7`, `AFN Stuttgart`, `Arabella`, `Bob`, `Club Mix`, `Dance FM`, `FFN`, `Galaxy`, `Gong`, `Ibiza`, `Jam FM`, `Kiss Kiss`, `Malibu`, `N-JOY`, `Paloma`, or `You FM`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, play [name] sound."*
-------------------------------
* starts the playback of the given sound - replace [name] by: `bee`, `beep`, `cat`, `cow`, `dog`, `donkey`, `elephant`, `elk`, `frog`, `goat`, `gorilla`, `horse`, `lion`, `parrot`, `pig`, `rattlesnake`, `vulture`, or `wolf`.


*"Computer, play [name] game."*
------------------------------
Launches the default Web browser and plays the given game - replace [name] by: `2048`, `Chess`, `Cube`, `Pacman`, `Tetris`, `TicTacToe`, or `Tower`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, change to [category] wallpaper."*
---------------------------------------------
Sets a random photo from Unsplash as desktop background, just replace [category] by: `beach`, `car`, `city`, `nature`, `plane`, or `space`.


*"Computer, open [name] settings."*
----------------------------------
Launches the Windows settings - replace [name] by: `activation`, `apps`, `background`, `backup`, `bluetooth`, `color`, `date`, `default apps`, `developer`, `display`, `ethernet`, `lockscreen`, `maps`, `printer`, `proxy`, `recovery`, `speech`, `start`, `system` *(the top level settings!)*, `taskbar`, `themes`, `time`, `update`, `USB`, `VPN`, or `Wifi`.

When finished say: *"Computer, close system settings"* to close the Windows settings.


*"Computer, show [name] manual."*
--------------------------------
Launches the default Web browser with the given online manual - replace [name] by: `Ant`, `Apple`, `Audacity`, `Azure`, `Bash`, `Blender`, `Chrome`, `Edge`, `Firefox`, `GCC`, `Git`, `Jenkins`, `MSBuild`, `OBS Studio`, `PowerShell`, `Serenade`, `SystemRescue`, `Toyota`, `Vim`, `Voice` *(yes, this page!)*, `Volkswagen`, or `Windows`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


*"Computer, show [name] rate."*
--------------------------------
Launches the default Web browser with the given exchange rate. Just replace [name] by: `Bitcoin`, `Ether`, `Euro`, `Tether`, or `US dollar`.

When finished say: *"Close tab"* or: *"Computer, close [name] browser"* to close the Web browser.


🔊 Audio Voice Commands
------------------------
* *"Computer, turn volume off"* - mutes audio
* *"Computer, shut up"* - mutes the audio
* *"Computer, turn volume on"* - unmutes audio
* *"Computer, turn volume up"* - increases the audio volume by 10%
* *"Computer, turn volume down"* - decreases the audio volume by 10%


💭 Various Voice Commands
-------------------------
* *"Computer, connect VPN"* - connects to VPN
* *"Computer, come on"*
* *"Computer, give me five"*
* *"Computer, locate my phone"*
* *"Computer, repeat last reply"* - repeats the last reply given
* *"Computer, roll a dice"* - returns a dice number
* *"Computer, sorry"* 
* *"Computer, tell joke."*
* *"Computer, tell quote."*
* *"Computer, thank you."*


*"Computer, [farewell]."*
-------------------------
Say farewell to the computer, replace [farewell] by: `bye`, `bye-bye`, `good-bye`, `I'll be back`, `see you`, or `see you later`.
