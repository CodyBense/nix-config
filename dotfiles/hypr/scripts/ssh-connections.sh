#!/usr/bin/env bash

FILE=$HOME/.local/share/ssh-connections.txt

cat ${FILE} | cut --delimiter ',' --fields 1 | tv >/tmp/ssh-connections

mapfile -t username < <(cat "${FILE}" | cut --delimiter ',' --fields 2) || exit 0
connections=$(cat /tmp/ssh-connections)

case "${connections}" in
vault)
    kitten ssh "${username[0]}"@"${connections}"
    ;;
pikachu)
    kitten ssh "${username[1]}"@"${connections}"
    ;;
maul)
    kitten ssh "${username[2]}"@"${connections}"
    ;;
*)
    noctalia-shell ipc call toast send '{"title": "SSH", "body": "Not a valid ssh connection"}'
    ;;

esac
