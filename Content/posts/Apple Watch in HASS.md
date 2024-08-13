---
date: 2024-08-12 20:53
description: Making it possible to detect your presence via your Apple Watch in your Home Assistant Smart Home System.
id: Apple Watch in HASS
tags: hass, apple_watch, bluetooth, presence_detection
---

Each device capable of Bluetooth communication has a Bluetooth MAC address, a unique address that can be used to fingerprint / identify the device. This can of course be very useful in smart home systems if for example you want certain things to happen when you come home or leave the house. But this can also be used for nefarious activities by bad people. Due to the risk of this sort of bad behaviour, Apple made it so the Apple Watch (and iPhones), randomly change their Bluetooth MAC address every 15 minutes or so, making it hard to use for presence detection at home.

# Prerequisites

But with a spare Raspberry Pi, and the [Theengs BLE MQTT gateway](https://gateway.theengs.io/), you will be able to get around this limitation.

# Setup

1. Open Settings on your Apple Watch / General / About / Bluetooth, note down the Address, should be of the form: XX:XX:XX:XX:XX:XX.
2. Open the Keychain Access application on your MacOS.
3. Click iCloud in the left sidebar.
4. Type in Bluetooth in the search bar in the top right.
5. Double click on a few of the GUIDs that you see, looking for an Account field of the form: Public XX:XX:XX:XX:XX:XX.
6. When you find one that matches the address from step 1, click show Password, type in your MacOS password, then copy out the XML, and paste it in a text file.

It should look something like this:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Remote IRK</key>
	<data>
	ABCDeasdasdeada7s7z7g==
	</data>
</dict>
</plist>
```

Armed with this Remote IRK and the Bluetooth Mac Address from before, we will be able to set things up on the Raspberry Pi.

# Installation

On your Raspberry Pi, install the python pip package called `TheengsGateway`.

# Run

`python3 -m TheengsGateway -H IP_ADDR_MQTT -P PORT_MQTT --identities WATCH_BT_MAC_ADDRESS WATCH_BT_IRK`

-   IP_ADDR_MQTT: The IP Address of your MQTT server.
-   PORT_MQTT: The port number of your MQTT server.
-   WATCH_BT_MAC_ADDRESS: The Apple Watch Bluetooth Mac Address found in step 1 above.
-   WATCH_BT_IRK: The Remote IRK Found at the end of step 6.

![Apple Watch in HASS](/res/apple_watch_in_hass.png)
