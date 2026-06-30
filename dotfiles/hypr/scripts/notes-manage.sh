#!/usr/bin/env bash

ACTION=$(gum choose sync open new)

case $ACTION in
"sync")
    rsync -rtu $HOME/org/ cody@maul:$HOME/ && rsync -rtu cody@maul:$HOME/org $HOME/
    noctalia-shell ipc call toast send '{"title": "Notes", "body": "Syncing org is complete"}'
    ;;
"open")
    emacsclient -n -e '(progn (select-frame-set-input-focus (selected-frame)) (org-roam-node-find))'
    ;;
"new") ;;
esac
