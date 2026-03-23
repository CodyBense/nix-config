#!/usr/bin/env bash

FILE=$HOME/.local/share/ssh-connections.txt

kitty --app-id ssh-connections -o font_features=none -e bash -c "cat ${FILE} | cut --delimiter ',' --fields 1 | tv > /tmp/ssh-connections"

mapfile -t username < <(cat "${FILE}" | cut --delimiter ',' --fields 2) || exit 0
connections=$(cat /tmp/ssh-connections)

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
