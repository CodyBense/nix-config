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
        cp ~/nix-config/templates/devenv/"$1".nix devenv.nix
        devenv shell
        devenv allow
        cat ~/nix-config/templates/devenv/.envrc > .envrc
        direnv allow
    }

    projectCreate() {
        local language="$1"
        local parentDir="$2"
        local projectName="$3"

        case "$language" in
        # go rust zig c python bash
        go)
            echo '{{ Color "99" " Creating a go project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            ${pkgs.go}/bin/go mod init github.com/CodyBense/"$projectName"
            git init
            cat ~/nix-config/dotfiles/git/Go.gitignore >"$parentDir"/"$projectName"/.gitignore
            envrcCreate "$language" "$parentDir" "$projectName"
            return
            ;;
        rust)
            echo '{{ Color "99" " Creating a rust project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            ${pkgs.cargo}/bin/cargo new "$parentDir"/"$projectName"
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        zig)
            echo '{{ Color "99" " Creating a zig project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            ${pkgs.zig}/bin/zig init
            git init
            cat ~/nix-config/dotfiles/git/Zig.gitignore >"$parentDir"/"$projectName"/.gitignore
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        python)
            echo '{{ Color "99" " Creating a python project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            ${pkgs.uv}/bin/uv init "$parentDir"/"$projectName"
            envrcCreate "$language" "$parentDir" "$projectName"
            ;;
        bash)
            echo '{{ Color "99" " Creating a bash project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
            echo
            mkpdir "$parentDir" "$projectName"
            cd "$parentDir"/"$projectName" || exit
            git init
            cat ~/nix-config/dotfiles/git/Shell.gitignore >"$parentDir"/"$projectName"/.gitignore
            printf "#!/usr/bin/env bash\n\n" >"$projectName"
            chmod +x "$projectName"
            ;;
        *)
            echo '{{ Color "99" " Creating a project "}}' | ${pkgs.gum}/bin/gum format -t template
            echo
            printf '{{ Color "99" " Creating project @ %s/%s "}}' "$parentDir" "$projectName" | ${pkgs.gum}/bin/gum format -t template
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
            'Create a new project'

        local projectName
        projectName=$(${pkgs.gum}/bin/gum input --placeholder "Project Name")
        [[ -z "$projectName" ]] && exit 1

        local parentDirChoice
        parentDirChoice=$(${pkgs.gum}/bin/gum choose github projects)

        local parentDir
        case "$parentDirChoice" in
        github)
            paretDir="$HOME"/workspaces/github/CodyBense
            ;;
        *)
            paretDir="$HOME"/workspaces/projects
            ;;
        esac

        local languageChoice
        languageChoice=$(${pkgs.gum}/bin/gum choose go rust zig c python bash other)

        projectCreate "$languageChoice" "$paretDir" "$projectName"

        return 0
    }

    main

  '';
}
