#!/bin/bash


cd ~
echo -e "Generating ssh key...\n"
echo "Give your ssh key a comment: "
read keyComment
ssh-keygen -t ed25519 -C "$keyComment"
echo -e "Starting ssh-agent...\n "
eval "$(ssh-agent -s)"
echo -e "Adding ssh key to ssh-agent...\n"
ssh-add ~/.ssh/id_ed25519
echo -e "Now add this key to your github account: \n"
cat ~/.ssh/id_ed25519.pub
echo "Done and ready? If so, press enter..."
read placeholder
echo "Testing connection with github..."
ssh -T git@github.com
echo "Done!"
