#!/bin/bash
# Install sleepwatcher
cd /tmp
curl -O https://raw.githubusercontent.com/OpenFibers/sleepwatcher/master/sleepwatcher_2.2.tar
tar -zxvf sleepwatcher_2.2.tar
cd sleepwatcher_2.2
sudo mkdir -p /usr/local/sbin /usr/local/share/man/man8
sudo cp sleepwatcher /usr/local/sbin
sudo cp sleepwatcher.8 /usr/local/share/man/man8
sudo cp config/de.bernhard-baehr.sleepwatcher-20compatibility.plist /Library/LaunchAgents
sudo cp config/rc.* /etc
cd ..
rm -r sleepwatcher_2.2*
# Add bluetooth script to /etc/rc.wakeup (the script requires root)
sudo tee -a /etc/rc.wakeup <<EOF
kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport
kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport
EOF
# Load the agent to start sleepwatcher
sudo launchctl load /Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility.plist
