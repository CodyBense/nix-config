#!/usr/bin/env bash

FILE=$HOME/.local/share/ssh-connections.txt

connections=$(cat "${FILE}" | cut --delimiter ',' --fields 1 | rofi -dmenu -p "connections: ") || exit 0
mapfile -t username < <(cat "${FILE}" | cut --delimiter ',' --fields 2) || exit 0

case "${connections}" in
vault)
    kitty --title "${connections}" ssh "${username[0]}"@"${connections}"
    ;;
pikachu)
    kitty --title "${connections}" ssh "${username[1]}"@"${connections}"
    ;;
192.168.1.129)
    kitty --title "${connections}" ssh "${username[2]}"@"${connections}"
    ;;
*)
    noctalia-shell ipc call toast send '{"title": "SSH", "body": "Not a valid ssh connection"}'
    ;;

esac
