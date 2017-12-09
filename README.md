# hidpi_osx
Enable HiDPI mode on OS X


# Update

- This is outdated. Try https://github.com/avibrazil/RDM on macOS High Sierra
- Also, if you 'want to use a HiDPI resolution that is half the native size of the monitor, but this doesn't work', see http://www.madrau.com/support/support/faq.html

- Also, just a reference here https://comsysto.github.io/Display-Override-PropertyList-File-Parser-and-Generator-with-HiDPI-Support-For-Scaled-Resolutions/


# HiDPI on Mac OS X EL Capitan, Dell U3011 

![image/png](http://chengguangnan.com/uploads/1956390242)

## Overview

El Capitan:

Turn off System Integrity Protection so we can copy file to /System

- Reboot your Mac into Recovery Mode by restarting your computer and holding down Command+R until the Apple logo appears on your screen.
- Click Utilities > Terminal.
- In the Terminal window, type in csrutil disable and press Enter.
- Restart your Mac.


Step 1:

    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES;
    sudo defaults delete /Library/Preferences/com.apple.windowserver DisplayResolutionDisabled;
    
Step 2:

Create an override file for your display. You may use [my script](https://github.com/chengguangnan/hidpi_osx) to do that. 

	sudo ruby hidpi_osx.rb

Step 3:

Reboot, HiDPI mode is available. 

## Reference

- http://www.tonymacx86.com/graphics/102321-guide-add-your-custom-retina-hidpi-resolution-your-desktop-display.html
- https://github.com/chengguangnan/hidpi_osx
