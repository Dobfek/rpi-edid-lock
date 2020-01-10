# Raspberry Pi EDID locker

Notes by Dobfek:
My TV was turned on by the RPi 3B, and the lower half of the picture using HDMI was completely black approx 40% of the time.
Reconnecting the HDMI cable instantly solved the problem, but it 2020, so it has to be solved in a more "elegant" way.

I modified neatsoft's script to work with LibreELEC.

It was tested to be working with LE 7.0.3 + RPi 3B.

Original Readme.md:
This utility creates the edid.dat file and changes config.txt to fix Raspberry Pi hdmi configuration issues.

    usage: rpi-edid-lock.sh [-l|-u]
    -l - lock
    -u - unlock

[Raspberry Pi FAQ: TV is not detected unless powered on first](http://kodi.wiki/view/Raspberry_Pi_FAQ#TV_is_not_detected_unless_powered_on_first)
