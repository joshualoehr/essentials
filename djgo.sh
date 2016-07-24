#!/bin/bash

SLOGANS=("GO DJANGO, I CHOOSE YOU!" "DJANGO, PLUG IN, POWERRRR UP!" "DJANGO POWERS, ACTIVATE!" "DJAAAAAANGOOOOOO!" "IT'S TIME TO D-D-D-D-DJANGO!")
NUM=$(( ( RANDOM % ${#SLOGANS[@]} )))

clear
echo -e "\e[93;44;1m                                         "${SLOGANS[NUM]}"                                         \e[0m"

tmux rename-window server
tmux split-window -h
tmux select-pane -t 0
tmux send-keys "./djshell.sh" Enter
tmux select-pane -t 1
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "cd ~/django" Enter
tmux send-keys "workon django" Enter
tmux send-keys "fab runserver" Enter
tmux select-pane -t 1
tmux send-keys "cd ~/django/wwu_housing" Enter
