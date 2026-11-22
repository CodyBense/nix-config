#!/usr/bin/env bash

filePath=$1

if [ -z filePath ]; then
    kitty --title yazi --app-id files yazi

else
    kitty --title yazi --app-id files yazi $filePath
fi
