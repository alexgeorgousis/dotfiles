state=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [ "$state" = "yes" ]; then
    echo '{"text": "", "tooltip": "Bluetooth is ON", "class": "on"}'
else
    echo '{"text": "", "tooltip": "Bluetooth is OFF", "class": "off"}'
fi

