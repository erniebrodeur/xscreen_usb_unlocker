# XscreenUsb

This gem provides a command line application that will control xscreensaver's lock/unlock features via connecting/disconnecting a given USB device.

This will work best with a device that presents a unique serial number, and you have with you all the time . . . like your smart phone.  In fact I designed this to be used with an android phone in usb debugging mode (so it will register with the system).  I don't have to mount the disk, simply plugging it in is enough.

## Installation

    $ gem install xscreen_usb_unlocker

## Usage

To make sure it's not any device plugged or unpluged, you have to supply either a serial or a device id to scan for.

For now, the serial can be found with:

		$ lsusb -v |grep Serial

Once you find the device (if it has a serial, most phone's do.)

		$ xscreen_usb_unlocker -s SERIAL

If it doesn't provide a serial, you can also use a device id.  Either the vendor, device or both can be supplied in a `vendor:device` format.

To find these just run `lsusb` and look for the `1234:ABCD` piece, that is your device id.

		$ xscreen_usb_unlocker -d 1234:ABCD

		$ xscreen_usb_unlocker -d 1234:

		$ xscreen_usb_unlocker -d :ABCD

You can also save these so you don't have to retype them, or have them in your history:

		$ xscreen_usb_unlocker -s SERIAL -d 1234:ABCD --save-config

Last, it can be daemonized, if this happens it will write a log to your homedirectory in: `~/.logs/xscreen_usb_unlocker.log`.

		$ xscreen_usb_unlocker -D

If you unlock xscreensaver by hand, you are not disabling this, the next time you plug/unplug your usb device, it will lock again.  This is useful if for some reason your usb device isn't available, you can still use your system as normal.

## SECURITY

This is incredibly important to understand, their isn't any.  This isn't a tool designed to secure your workstation, I can think of half a dozen ways to get past this easily.

Instead, this tool is for convience, to help facilitate simple locking/unlocking in a casual business/home environment.

All it does is start/kill (safely) xscreensaver based on scanning for usb devices.

## TODO:

* Add a --kill option to remove the other daemonizes.
* Add a --name to trap for the device name (regex? substring?)
* Add basic device detection to print out a pretty table to help configure it (offer options and save automatically?)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
