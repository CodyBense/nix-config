#!/usr/bin/env bash
DIR=$HOME/workspaces/github/CodyBense

kitty --app-id project-launch --directory ~/workspaces/github/CodyBense -o font_features=none -e bash -c "ls | tv dirs > /tmp/project-selection"
project=$(cat /tmp/project-selection)

emacsclient -n -re "${DIR}"/"${project}"

SESSIONEXIST=$(tmux has-session -t "$project")
if $SESSIONEXIST; then
    tmux new -s "$project" -c "$DIR"/"$project" -d

    # tmux new-window -t "$project":1 -n 'Bash'

    # tmux new-window -t "$project":2 -n 'Files'
    # tmux send-keys -t 'Files' "yazi  ${DIR}/${project}/" C-m

    # tmux new-window -t "$project":3 -n 'Monitor'
    # tmux send-keys -t 'Monitor' 'btop' C-m

    # tmux next-window
fi

kitty --app-id project --title $project -e tmux attach -t $project
