#!/usr/bin/env bash

actions=( "wink" "double blink" "close your eyes" "jump" )

reverse=$(( $1 & 16 ))

declare -a handshake

for (( idx=0, len=${#actions[@]}; idx < len; ++idx )); do
    if (( $1 & (2 ** idx) )); then
        if (( reverse )); then
            handshake=( "${actions[idx]}" "${handshake[@]}" )
        else
            handshake+=( "${actions[idx]}" )
        fi
    fi
done

(IFS=","; echo "${handshake[*]}")
