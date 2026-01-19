{
  description = "Install script";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.install-script;
    packages.x86_64-linux.install-script =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "install-script" ''

        echo '{{ Color "99" " Building nix-config " }}' | ${pkgs.gum}/bin/gum format -t template
        sleep 1
        hostName=$(${pkgs.gum}/bin/gum choose "revan" "pikachu")

        # ensuring hardware-configuration.nix is correct
        sudo cat /etc/nixos/hardware-configuration.nix > hosts/$hostName/hardware-configuration.nix

        sleep 1

        # echo '{{ Color "99" " Building for $hostName " }}' | ${pkgs.gum}/bin/gum format -t template
        sudo nixos-rebuild switch --flake ~/nix-config#$hostName

        sleep 1

        doomEmacsInstall=$(${pkgs.gum}/bin/gum input --placeholder "Do you want to insall doom emacs: (y/n)")
        if (( $doomEmacsInsall == "y" )); then
            git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
            ~/.emacs.d/bin/doom install
        fi

        echo '{{ Color "99" " Creating Directories " }}' | ${pkgs.gum}/bin/gum format -t template

        if [ ! -d $HOME/workspaces/github/CodyBense ]; then
            mkdir -p $HOME/workspaces/github/CodyBense
        fi

        if [ ! -d $HOME/workspaces/projects ]; then
            mkdir -p $HOME/workspaces/projects
        fi

        echo '{{ Color "99" " Completed setup " }}' | ${pkgs.gum}/bin/gum format -t template
        sleep 1
        echo '{{ Color "99" " Rebooting" }}' | ${pkgs.gum}/bin/gum format -t template
        sleep 1
        # reboot
      '';
  };
}
