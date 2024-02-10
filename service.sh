(#!/system/bin/sh

# Function to perform your action
correct() {
    echo "Colour correction On"
    # Add your action here
    # set saturation - number after f (floating integer) - can be between 1.0 and 2.0
    service call SurfaceFlinger 1022 f 1.1
    # enable custom RGB settings - 1=on / 0= off
    service call SurfaceFlinger 1023 i32 1
    # set RGB values
    # format (after i32 1) is f R f 0 f 0 f 0 f 0 f G f 0 f 0 f 0 f 0 f B f 0 f 0 f 0 f 0 f 1
    # not that there's a reason to change it but last digit in line MUST always be 1
    service call SurfaceFlinger 1015 i32 1 f 1.05 f 0 f 0 f 0 f 0 f 0.91 f 0 f 0 f 0 f 0 f 0.995 f 0 f 0 f 0 f 0 f 1
}

# wait till boot completed - thanks to jcmm11
until [ "$(getprop sys.boot_completed)" = 1 ]; do
    sleep 1
done

# Infinite loop to continuously monitor the value of night_display_activated
while true; do
    # Get the current value
    value=$(settings get secure night_display_activated)

    # Check if the value switches from 1 to 0
    if [ "$value" = "0" ] && [ "$prev_value" = "1" ]; then
        correct
    fi

    # Store the current value for comparison in the next iteration
    prev_value="$value"

    # Sleep for some time before checking again
    sleep 1  # You can adjust the interval as per your requirement
done
)&

