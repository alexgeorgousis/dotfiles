# Installation Tips

## Connecting to WiFi

Official guide [here](https://wiki.archlinux.org/title/Iwd#Connect_to_a_network).

1. Run `iwctl`
2. In the `iwctl` prompt run `station list` to get the name of your wifi device - you should see something like `wlan0` or `wlan1`
3. Run `station <name> connect <SSID>`
    - If you don't know your WiFi's SSID by heart, run `station <name> scan` to find it
4. Type in your password when requested
5. You should see the `connect` command from above (which is still running) go to `connecting` and then `connected`