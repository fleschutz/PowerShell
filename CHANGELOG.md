* **Version 1.5.0**
    - New feature: Dark Theme (iOS 13 and newer).
    - Update: Migration to Swift 5.1.
    - Improvement: Updated Pod dependencies in the Example app.
    - Improvement: DFU Library version 4.6.1.
    - Bugfix: Crashes related to iOS 13 have been fixed.
    
* **Version 1.4.0**
    - Update: Updated bundled Thingy FW to 2.2.0.
    - New feature: Option to set Thingy NFC content (library only).
    - Improvememnt: Option to read MTU (library only).
    - Improvement: New look and feel of the sample app.
    - Improvement: Updated Pod dependencies in the Example app.
    - Update: Migration to Swift 4.2.
    - Bugfix: Fixed UI on iPhone X.

* **Version 1.3.2**
    - Bugfix: Fixed bug causing delete Thingy action sheet not to work on iPad causing a crash.

* **Version 1.3.1**
    - Bugfix: Fixed bug causing app to crash when deleting the first connected Thingy.
    - Improvement: iOS 11 UI refresh.
    - Improvement: iPhone X UI adaptation.

* **Version 1.3.0**
    - Improvement: Thingy SDK will now return nil instead of 0.0.0 on version reading if it's not ready.
    - Improvement: All view presentations now are done from navigation controllers instead of detached views.
    - Improvement: Updated Pod dependencies in the Example app.
    - Update: Removed code usages that are deprecated in Swift 4, like String.characters.
    - Bugfix: Fixed bug causing duplicate Thingy peripherals to show during scanning.
    - Bugfix: Fixed bug causing DFU update alerts not to show on first connection after adding a new Thingy peripheral.
    - Update: Updated bundled Thingy FW to 2.1.0.

* **Version 1.2.0**
    - Update: NFC Pairing support in example application.
    - Update: Thingy battery service implemented in SDK and example app.
    - Update: iOS 11 Support in example app.
    - Improvement: Added new DFU progress delegate method that reports back current FW part being uploaded.
    - Improvement: iOS 11 support, and iPhone X UI improvements in example application.
    - Improvement: Confirmation before removing peripherals.
    - Improvement: Removing peripherals on iOS 11 can now be done by swiping further to the right on main menu.

* **Version 1.1.2**
    - Bugfix: Cloud view will only report errors on error HTTP Codes PR #16.
    - Update: Updated bundled Thingy FW to 2.0.0.

* **Version 1.1.1**
    - Improvement: Updated maximum time interval to 1 minute for Temperature and Humidity notifications.
    - Improvement: Updated maximum light intensity measurement interval to 1 minute.

* **Version 1.1**
    - Bugfix: Temperature values below 0 overflow fixed.
    - Improvement: Updated maximum time interval to 1 minute for Pressure notificaitons.
    - Improvement: Updated minimum motion processing frequency to 5Hz as this is the minimum supported by the MPU.
    - Improvement: Updated minimum LED breathe delay to 50 ms.
    - Improvement: Fixed LED delay interval text field on iPad where hitting the done button on the keyboard had no effect.

* **Version 1.0**
    - Initial release of the Thingy SDK and Example app.
