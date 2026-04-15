# pkgs/helium-browser/package.nix
{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  wrapGAppsHook,
  alsa-lib,
  at-spi2-atk,
  cairo,
  cups,
  dbus,
  expat,
  libdrm,
  libxkbcommon,
  mesa,
  nss,
  pango,
  udev,
  xorg,
  gtk3,
  glib,
  gdk-pixbuf,
  atk,
}:

let
  version = "0.8.5.1";
in
stdenv.mkDerivation {
  pname = "helium-browser";
  inherit version;

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64_linux.tar.xz";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace with real hash
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    libdrm
    libxkbcommon
    mesa
    nss
    pango
    udev
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    gtk3
    glib
    gdk-pixbuf
    atk
  ];

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    runHook preInstall

    # The tarball unpacks to a directory like helium-0.8.5.1/
    cd helium-${version}

    mkdir -p $out/share/helium $out/bin $out/share/applications $out/share/icons

    # Copy all browser files
    cp -r . $out/share/helium/

    # The binary inside the tarball is named 'chrome' (Chromium upstream name)
    # Wrap it so NixOS-specific environment variables are set
    makeWrapper $out/share/helium/chrome $out/bin/helium \
      --suffix PATH : ${lib.makeBinPath [ xorg.xdpyinfo ]} \
      --set CHROME_WRAPPER helium \
      --add-flags "--no-sandbox" # only if needed; prefer user namespaces

    # Desktop entry
    cat > $out/share/applications/helium.desktop <<EOF
    [Desktop Entry]
    Version=1.0
    Name=Helium
    Comment=Private, fast, and honest web browser
    Exec=$out/bin/helium %U
    Terminal=false
    Type=Application
    Icon=helium
    Categories=Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
    EOF

    runHook postInstall
  '';

  meta = with lib; {
    description = "Private, fast, and honest web browser based on Chromium";
    homepage = "https://helium.computer";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "helium";
  };
}
