#!/bin/sh

# Get the names of the connected microphones
mics=$(ls /dev/snd/controlC* | sed 's/\/dev\/snd\/controlC//g')

# Prompt the user to select a microphone using dmenu
selected_mic=$(echo "$mics" | dmenu -i -p "Select a microphone:")

# Prompt the user to adjust the volume of the selected microphone using dmenu
options="0\n10%\n20%\n30%\n40%\n50%\n60%\n70%\n80%\n90%\n100%"
selected_option=$(echo -e "$options" | dmenu -i -p "Select a volume:")

# Adjust the volume of the selected microphone using amixer
amixer -c $selected_mic set Capture $selected_option

echo "Microphone volume set to $selected_option for $selected_mic."

