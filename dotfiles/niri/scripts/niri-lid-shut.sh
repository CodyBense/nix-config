#!/usr/bin/env bash

monitors=
monitors_arr=()
monitor_1="eDP-1"
monitor_2="DP-3"
state=true

# sleep 1; systemctl suspend

get_monitors () {
    monitors=$(niri msg --json outputs | jq '[.[] | select( .current_mode == 0)]' | jq '[.[].name] | join(" ")' -r)
    read -ra monitors_arr <<< "${monitors}"
}

# check_monitors () {
    # for monitor in "${monitors_arr[@]}"; do
    #     if [[ "${monitor}" == "${monitor_2}" ]]; then
    #         echo "${#monitors_arr[@]}"
    #         state=false
    #     elif [[ "${monitor}" == "${monitor_1}"  ]]; then
    #         state=true
    #     fi
    # done
# }

handle_suspend () {
    if [[ ${#monitors_arr[@]} == 1 ]]; then
        if [[ "${monitors_arr[0]}" == "${monitor_1}" ]]; then
            sleep 1
            systemctl suspend
        fi
    fi
}

get_monitors
handle_suspend
