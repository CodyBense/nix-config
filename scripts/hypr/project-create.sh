#!/usr/bin/env bash

updateDevenv() {
    cat "${HOME}/nix-config/templates/${1}.nix" >> $2/devenv.nix
}

createProject() {
    local language="$1"
    local projectName="$2"
    local projectPath=$HOME/workspaces/github/CodyBense/$projectName
    notify-send "Project: ${projectPath}"

    case "${language}" in
        go)
            mkdir -p $HOME/workspaces/github/CodyBense/$projectName
            cd $HOME/workspaces/github/CodyBense/$projectName
            git init
            go mod init github.com/CodyBense/$projectName
            devenv init && devenv allow
            updateDevenv "go" $projectPath
            git add . && git commit -m "init ${projectName}"
        ;;
        rust)
            echo "RUST"
            mkdir -p $HOME/workspaces/github/CodyBense/$projectName
            cd $HOME/workspaces/github/CodyBense/$projectName
            cargo init
            devenv init && devenv allow
            updateDevenv "rust" $projectPath
            git add . && git commit -m "init ${projectName}"
        ;;
        zig)
            echo "ZIG"
            mkdir -p $HOME/workspaces/github/CodyBense/$projectName
            cd $HOME/workspaces/github/CodyBense/$projectName
            git init
            zig init
            devenv init && devenv allow
            updateDevenv "zig" $projectPath
            git add . && git commit -m "init ${projectName}"

        ;;
        c)
            echo "C"
        ;;
        python)
            echo "PYTHON"
            mkdir -p $HOME/workspaces/github/CodyBense/$projectName
            cd $HOME/workspaces/github/CodyBense/$projectName
            uv init
            devenv init && devenv allow
            updateDevenv "python" $projectPath
            git add . && git commit -m "init ${projectName}"
        ;;
        *)
            echo "OTHER"
            mkdir -p $HOME/workspaces/github/CodyBense/$projectName
            cd $HOME/workspaces/github/CodyBense/$projectName
            devenv init && devenv allow
            git add . && git commit -m "init ${projectName}"
        ;;
        esac
}

main() {
        gum style \
        --foreground 212 --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        'Create a new project'

        local projectName=$(gum input --placeholder "Project Name")

        local langChoice=$(gum choose go rust zig c python bash other)

        printf "Createing ${projectName}\n\tLanguage: ${langChoice}\n"

        createProject "${langChoice}" "${projectName}"
}

main
