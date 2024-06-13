######################### MY OWN VARS AND SETTINGS #########################

# Moved to the .zshenv!

######################### Directory jumping #########################

alias govim="cd $HOME/.config/nvim/"

alias gozsh="cd $ZDOTDIR"

alias golocal="cd $WORK_DIR/.local"

alias gosuck="cd $WORK_DIR/suckless"

alias sd="cd \$(find ./ -type d | fzf )"

alias sf="nvim \$(find ./ -type f | fzf )"

alias ed="cd .. && cd \$(find ./ -type d | fzf )"

alias ef="cd .. && nvim \$(find ./ -type f | fzf )"

######################### OTHER #########################

alias ls="ls --color"

alias nv="nvim ."

alias rn="ranger ."

alias helpme="cat $ZDOTDIR/custom.zsh"

alias srb='source $HOME/.zshrc'

alias als="nvim $ZDOTDIR/custom.zsh"

alias tms='tmux ls'

alias hl="hledger"

alias hwe="hledger bal -W expenses -b $(date +"%Y-%m")"

pro() { PS1="($1) ${PS1}" ;}

vopen() {
    echo -e "Decrypting the archive...\n"
    gpg "$1"
    tarName="${1//\.gpg/}"
    echo -e "Archive name: $tarName"
    echo -e "Unpacking the archive...\n"
    tar xzf "$tarName"
    dirName="${tarName//\.tar\.gz/}"
    echo "Directory name: $dirname"
    echo -e "Deleting decrypted archive...\n"
    rm -rf "$tarName"
    echo -e "Done!\n"
    ls
}

vclose() {
    echo -e "Deleting old encrypted archive...\n"
    rm -rf "$1.tar.gz.gpg"
    echo -e "Creating new unencrypted archive...\n"
    sudo tar -czf "$1.tar.gz" "$1"
    echo -e "Deleting unencrypted directory...\n"
    sudo rm -rf "$1"
    echo -e "Encrypting new archive...\n"
    gpg -c "$1.tar.gz"
    echo -e "Deleting unencrypted archive...\n"
    rm -rf "$1.tar.gz"
    echo -e "Done:\n"
    ls
}

pandock() {
sudo docker run --rm \
       --volume "$(pwd):/data" \
       --user $(id -u):$(id -g) \
       pandoc/extra $1 -o $2 --template eisvogel -V lang=pl

}

mig() {
    git remote set-url origin $1
    git push
    cd ..
}

######################### GIT STUFF ######################

gsa() {
    cd $WORK_DIR/
    prev=$(pwd)
    repos=($(ls -d */))
    for i in ${repos[@]}
    do
        cd $MAIN_DIR/"$i"
        echo -e "-------------> ${i}		"
        git status -b -s
        echo -e "<-------------"
        sleep 0.1
        echo -e "\n\n"
    done
    cd $prev
}

gpa() {
    cd $WORK_DIR/
    prev=$(pwd)
    repos=($(ls -d */))
    for i in ${repos[@]}
    do
        cd $MAIN_DIR/"$i"
        echo -e "-------------> ${i}		"
        git pull
        echo -e "<-------------"
        sleep 0.1
        echo -e "\n\n"
    done
    cd $prev
}

alias gp='git push'
alias gt='git pull'
alias ga='git add -A'
alias gd='git diff'

#gc() { git commit -am "$1" ;}

acp() { git add . ; git commit -am "$1"; git push ;}

alias gne='git commit -a --amend  --no-edit'

alias glo='git log --oneline --graph --decorate'

alias gs='git status -b -s'

alias glv='git log --graph --decorate --all --oneline'

alias gla='git log --all --graph --decorate --stat'

######################### C STUFF ######################

cb() {
    arg="$1"
    name="${arg//\.c/}"
    echo $name
    gcc "$1" -o "$name"
}

cr() {
    arg="$1"
    name="${arg//\.c/}"
    echo $name
    gcc "$1" -o "$name"
    ./"$name"
}


######################### WORK STUFF ######################

mpi() {
    mosquitto_pub -h ils-warsaw.ubudu.com -t "$1" -m "$2"
}


msi() {

    mosquitto_sub -h ils-warsaw.ubudu.com -t "$1" -v
}

msread() {
    mosquitto_sub -h ils-warsaw.ubudu.com -t gw/"$1"/dev/"$2"/serial/read -v
}

mswrite() {
    mosquitto_sub -h ils-warsaw.ubudu.com -t gw/"$1"/dev/"$2"/serial/write -v
}


bcd() {

bcrc -b ils-warsaw.ubudu.com -s ucs -m "$1\r\n" -t $2 -g $3

}

pco() {

    picocom /dev/tty$1 --q --echo --b 115200

}

tma() {

    tmux a $1

}

cpx() {
    cat "$1" | xclip -selection clipboard
}

bmq() {
    $HOME/Downloads/ble_v2_dev_monitor-linux --mqtt-host ils-warsaw.ubudu.com --mqtt-port 1883 --mqtt-topic "$1"
}

flash() { nrfjprog --recover && nrfjprog --program "$1" --sectorerase && nrfjprog -r ;}

tb() { cat $1 | tty-table  ;}

burn() { sudo dd bs=4M if=$1 of=$2 status=progress oflag=sync ;}

#keychain --quiet ~/.ssh/gw-key-1
#source ~/.keychain/$HOST-sh

