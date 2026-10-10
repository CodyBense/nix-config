#!/usr/bin/env bash
DIR=$HOME/workspaces/github/CodyBense

function createTmuxSession() {
    local SESSION=$1
    local SESSIONEXISTS=$(tmux has-session -t "$SESSION")
    # notify-send "Does the session exist: $SESSIONEXISTS"
    if [ -z "$SESSIONEXISTS" ]; then
        tmux new -s "$SESSION" -c "$DIR"/"$SESSION" -d

        tmux new-window -t "$SESSION":1 -n 'Bash'

        tmux new-window -t "$SESSION":2 -n 'Files'
        tmux send-keys -t 'Files' "yazi  ${DIR}/${SESSION}" Enter

        tmux new-window -t "$SESSION":3 -n 'Monitor'
        tmux send-keys -t 'Monitor' 'btop' C-m

        tmux next-window
    fi
}

kitty --app-id project-launch --directory ~/workspaces/github/CodyBense -o font_features=none -e bash -c "ls | tv dirs > /tmp/project-selection"
project=$(cat /tmp/project-selection)

emacsclient -n -re "${DIR}"/"${project}"

TMUXEXIST=$(hyprctl clients -j | jq '.[] | select(.class == "kitty" and .title == "project")')
if [ -z "$TMUXEXIST" ]; then
    kitty --title "project" -o font_features=none -e tmux new-session -s "$project" -c "$DIR"/"$project"
fi
createTmuxSession "$project"
sleep 1
tmux switchc -t "$project"
sleep 1
hyprctl dispatch 'hl.dsp.focus({ window = "class:emacs" })'
