#!/usr/bin/env bash

DIR=$HOME/Documents/Obsidian/

new_notes() {
    new_options=$(printf "daily\nnotes\nprojects" | rofi -dmenu -p "Notes: ") || exit 0
    case "$new_options" in
        "daily")
            nvim $DIR/daily_notes/$(command date +"%Y-%m-%d").md
            ;;
        *)
            notify-send "Figure out how you want to implement new none daily notes"
            echo "- [ ] Figure out how you want to implement new none daily notes" >> $DIR/daily_notes/TODO.md
            ;;
    esac
}
choice=$(printf "sync\nopen\nnew" | rofi -dmenu -p "Notes menu: ") || exit 0
case $choice in 
    "sync") 
        rsync -rtu $HOME/Documents/Obsidian/* cody@vault:/data/Obsidian && rsync -rtu cody@vault:/data/Obsidian $HOME/Documents && notify-send "Syncing Obsidian is complete"
        sleep 1
        rsync -rtu $HOME/Documents/Notes/* cody@vault:/data/Notes && rsync -rtu cody@vault:/data/Notes $HOME/Documents && notify-send "Syncing Notes is complete"
        sleep 1
        rsync -rtu $HOME/org/* cody@vault:/data/org && rsync -rtu cody@vault:/data/org $HOME/ && notify-send "Syncing org is complete"
        ;;
    "open")
        note_dir=$(printf "$(command ls -t1 $DIR)" | rofi -dmenu -p "Note dir: ") || exit 0
        echo $note_dir
        emacsclient -c $DIR/$note_dir
        # kitty --title notes --app-id notes --directory $DIR/$notes_dir nvim -- .&
        ;;
    "new")
        new_notes
        ;;
    "*")
        exit 1
        ;;
esac
