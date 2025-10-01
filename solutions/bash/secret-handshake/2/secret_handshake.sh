#!/usr/bin/env bash

actions=( "wink" "double blink" "close your eyes" "jump" )

len=${#actions[@]}

reverse=$(( $1 & 1 << len ))

declare -a handshake

for (( idx=0; idx < len; ++idx )); do
    if (( $1 & 1 << idx )); then
        if (( reverse )); then
            handshake=( "${actions[idx]}" "${handshake[@]}" )
        else
            handshake+=( "${actions[idx]}" )
        fi
    fi
done

IFS=","
echo "${handshake[*]}"
