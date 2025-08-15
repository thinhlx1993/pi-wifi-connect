#!/bin/bash

WIFI_CONNECT_BIN="/home/thinh/pi-wifi-connect/wifi-connect"
sleep 60
while true; do
    # Check if wlan0 is connected to Wi-Fi
    if nmcli -t -f DEVICE,STATE d | grep -q "wlan0:connected"; then
        # Connected → Stop wifi-connect if running
        if pgrep -x "wifi-connect" > /dev/null; then
            echo "Wi-Fi connected. Stopping WiFi Connect..."
            pkill -x wifi-connect
        fi
    else
        # Not connected → Start wifi-connect if not already running
        if ! pgrep -x "wifi-connect" > /dev/null; then
            echo "No Wi-Fi. Starting WiFi Connect..."
            sudo "$WIFI_CONNECT_BIN" &
        fi
    fi
    sleep 10  # Check every 10 seconds
done
