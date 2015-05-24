#!/bin/bash
# Author Thomas Backlund
# Inspired by watch.sh by Mike Smullin

paths="./common ./ng index.html app-config.js app-modules.js"
sha_current=0
sha_built=0
tmuxnotify="$HOME/.TmuxNotify/tmux-notify.sh"
notifysuccess="#[bg=colour64,fg=white,bold]BUILD SUCCESS"
notifyfailure="#[bg=colour160,fg=white,bold]BUILD FAILED"
tputbold=$(command -v tput >/dev/null 2>&1 && tput bold; tput setab 2)
tputnormal=$(command -v tput >/dev/null 2>&1 && tput sgr0)

get_sha() {
    sha_current=$(ls -lR --time-style=full-iso $paths | sha1sum)
}

notify() {
    command -v $tmuxnotify >/dev/null 2>&1 && $tmuxnotify set "$1"
}

build() {
    sha_built=$sha_current
    notify "BUILDING..."
    make
    if [ $? = "0" ]; then
        notify "$notifysuccess"
    else
        notify "$notifyfailure"
    fi
}

watch_and_build() {
    while [[ $sha_current = $sha_built ]]; do
        sleep 1
        get_sha
    done
    build
}

watch() {
    while true; do
        echo -e  "\n${tputbold}Press Ctrl+C to exit. Ctrl+\\ to force build."
        echo -e "Watching . . . $tputnormal\n"
        watch_and_build
    done
}

init() {
    trap sha_built=0 SIGQUIT
    trap exit 0 SIGINT
    get_sha
    build
}

init
watch
