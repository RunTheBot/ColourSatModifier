(#!/system/bin/sh

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

