# ColourSatModifier

## A quick and dirty module to change the RGB and Saturation values via SurfaceFlinger directly, instead of using apps

I created this module to have an appless solution to **Justarandomguy's** post here:

https://forum.xda-developers.com/t/root-tune-saturation-white-balance-and-enable-hbm-on-your-pixel.4575403/

As i prefer, where its possible, to use a simple module featuring native commands or script to do the work of 
an app or in this case multiple apps....

Thanks for the idea and original concept go to Justarandomguy and his settings for the Pixel 6 Pro

The only active part of the module is service.sh:

```(#!/system/bin/sh

# wait till boot completed  - thanks to jcmm11
until [ "$(getprop sys.boot_completed)" = 1 ]
do
	sleep 1
done

sleep 30

# set saturation - number after f (floating integer) - can be between 1.0 and 2.0
service call SurfaceFlinger 1022 f 1.1
# enable custom RGB settings - 1=on / 0= off
service call SurfaceFlinger 1023 i32 1
# set RGB values
# format (after i32 1) is f R f 0 f 0 f 0 f 0 f G f 0 f 0 f 0 f 0 f B f 0 f 0 f 0 f 0 f 1
# not that theres a reason to change it but last digit in line MUST always be 1
service call SurfaceFlinger 1015 i32 1 f 0.957 f 0 f 0 f 0 f 0 f 0.976 f 0 f 0 f 0 f 0 f 1 f 0 f 0 f 0 f 0 f 1
)&
```

Please adjust to suit your own preferences, or device.

The settings can be changed in **service.sh**, in the format shown below 

For Saturation - change the x after f (floating point value) for a value between 1.0 and 2.0

```service call SurfaceFlinger 1022 f x```

For RGB - change the R, G, B values for ones you like - for your device:

``` service call SurfaceFlinger 1015 i32 1 f R f 0 f 0 f 0 f 0 f G f 0 f 0 f 0 f 0 f G f 0 f 0 f 0 f 0 f 1```

Note: You can also test the changes have been applied via an adb root shell by toggling the following and witnessing the difference between 1 (on) and 90) off states:

```service call SurfaceFlinger 1023 i32 0``` (off)

```service call SurfaceFlinger 1023 i32 1``` (on)

His post also includes info on achieving High Brightness Mode on the Pixel 6 Pro. As i was not looking for more apps to install to do this, and i just wanted an easy toggle for this mode for the occasions where i need it, outside, i decided to create a simple Quick Settings script using MacroDroid, which i already have installed for other things. You can find my shared macro by searching for **High Brightness Mode (Pixel 6 Pro)**. You will need to edit and add the custom HBM Quick Settings tile to your devices notifications pulldown, of course.

**Please note:** the included LICENSE only covers the module components provided by the excellent work of Zack5tpg'sMagisk Module Extended, which is available for here for module creators

https://github.com/Zackptg5/MMT-Extended/

All other work is credited above and no one may fork or re-present this module as their own for the purposes of trying to monetize this module or its content without all parties permission. The module comes specifically without an overall license for this intent.

---


### Project Stats ###

![GitHub release (latest by date)](https://img.shields.io/github/v/release/adrianmmiller/ColourSatModifier?label=Release&style=plastic)
![GitHub Release Date](https://img.shields.io/github/release-date/adrianmmiller/ColourSatModifier?label=Release%20Date&style=plastic)
![GitHub Releases](https://img.shields.io/github/downloads/adrianmmiller/ColourSatModifier/latest/total?label=Downloads%20%28Latest%20Release%29&style=plastic)
![GitHub All Releases](https://img.shields.io/github/downloads/adrianmmiller/ColourSatModifier/total?label=Total%20Downloads%20%28All%20Releases%29&style=plastic)
