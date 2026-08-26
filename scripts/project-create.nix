{
  pkgs ? import <nixpkgs> { },
}:

pkgs.writeShellApplication {
  name = "project-create";
  runtimeInputs = with pkgs; [
    cargo
    gum
    zig
    uv

  ];
  text = ''
    #!/usr/bin/env bash

    mkpdir() {
        mkdir -p "$1"/"$2"
    }

    launchProject() {
        local parentDir="$1"
        local projectName="$2"

        pkgs.kitty --title "$projectName" --session "$HOME"/nix-config/dotfiles/kitty/sessions/project.kitty-session -d "$parentDir"/"$projectName" &
        sleep 0.5
        emacsclient -n "$parentDir"/"$projectName"
    }

    # $1: language, $2: parentDir, $3: projectName
    envrcCreate() {
        cd "$2"/"$3"
        cp ~/nix-config/templates/devenv/.envrc "$2"/"$3"/.envrc
        cp ~/nix-config/templates/devenv/"$1".nix "$2"/"$3"/devenv.nix
        devenv shell
        devenv allow
        direnv allow
    }

    projectCreate() {
        local language="$1"
        local parentDir="$2"
        local projectName="$3"

        case "$language" in
        # go rust zig c python bash
        go)
            echo '{{ color "99" " creating a go project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            ${pkgs.go}/bin/go mod init github.com/codybense/"$projectName"
            git init
            cat ~/nix-config/dotfiles/git/go.gitignore >"$parentDir"/"$projectName"/.gitignore
            envrcCreate "$language" "$parentDir" "$projectName"
            return
            ;;
        rust)
            echo '{{ color "99" " creating a rust project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            ${pkgs.cargo}/bin/cargo new "$parentDir"/"$projectName"
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        zig)
            echo '{{ color "99" " creating a zig project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            ${pkgs.zig}/bin/zig init
            git init
            cat ~/nix-config/dotfiles/git/zig.gitignore >"$parentDir"/"$projectName"/.gitignore
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        python)
            echo '{{ color "99" " creating a python project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            ${pkgs.uv}/bin/uv init "$parentDir"/"$projectName"
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        bash)
            echo '{{ color "99" " creating a bash project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            git init
            cat ~/nix-config/dotfiles/git/shell.gitignore >"$parentDir"/"$projectName"/.gitignore
            printf "#!/usr/bin/env bash\n\n" >"$projectName"
            chmod +x "$projectName"
            ;;
        *)
            echo '{{ color "99" " creating a project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ color "99" " creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            git init
            ;;
        esac
    }

    main() {
        ${pkgs.gum}/bin/gum style \
            --foreground 212 --border-foreground 212 --border double \
            --align center --width 50 --margin "1 2" --padding "2 4" \
            'create a new project'

        local projectName
        projectName=$(${pkgs.gum}/bin/gum input --placeholder "project name")
        [[ -z "$projectName" ]] && exit 1

        local parentDirChoice
        parentDirChoice=$(${pkgs.gum}/bin/gum choose github projects)

        local parentDir
        case "$parentDirChoice" in
        github)
            parentDir="$HOME"/workspaces/github/codybense
            ;;
        *)
            parentDir="$HOME"/workspaces/projects
            ;;
        esac

        local languageChoice
        languageChoice=$(${pkgs.gum}/bin/gum choose go rust zig c python bash other)

        projectCreate "$languageChoice" "$parentDir" "$projectName"

        return 1
    }

    main

  '';
}
