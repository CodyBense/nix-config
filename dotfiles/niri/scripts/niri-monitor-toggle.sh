#!/usr/bin/env bash

monitors=
active_monitors=
monitors_arr=()
active_monitors=
active_monitors_arr=
monitor_1="eDP-1"
monitor_2="DP-3"
focused_window=$(niri msg --json workspaces | jq '.[] | select (.is_focused == true)' | jq '.active_window_id' -r)

get_monitors () {
    active_monitors=$(niri msg --json outputs | jq '[.[] | select( .current_mode == 0)]' | jq '[.[].name] | join(" ")' -r)
    read -ra active_monitors_arr <<< "${active_monitors}"
    monitors=$(niri msg --json outputs | jq '[.[].name] | join(" ")' -r)
    read -ra monitors_arr <<< "${monitors}"
}

switch_mon_1 () {
    niri msg output ${monitor_1} on
    sleep 0.5
    niri msg output ${monitor_2} off
    niri msg action focus-window --id "${focused_window}"
}

switch_mon_2 () {
    niri msg output ${monitor_2} on
    sleep 0.5
    niri msg output ${monitor_1} off
    niri msg action focus-window --id "${focused_window}"
}

external_attatched () {
    local len_active_monitors=${#active_monitors_arr[@]}

    case "${len_active_monitors}" in
        1)
            if [[ ${active_monitors_arr[0]} == "${monitor_2}" ]]; then
                switch_mon_1
            else
                switch_mon_2
            fi
            ;;
        2)
            switch_mon_2
            ;;
    esac
}

switch_workspaces () {
    local len_monitors=${#monitors_arr[@]}
    
    case "${len_monitors}" in
        1)
            niri msg output ${monitor_1} on
            ;;
        2)
            external_attatched
            ;;
    esac
}

get_monitors
switch_workspaces
