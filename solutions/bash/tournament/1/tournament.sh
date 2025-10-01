#!/usr/bin/env bash

row_pattern="%-30s | %2s | %2s | %2s | %2s | %2s\n"

declare -A opposite=( [win]=loss [loss]=win [draw]=draw )
declare -A outcome_points=( [win]=3 [loss]=0 [draw]=1 )

expand_data() {
    local home_team guest_team outcome

    while IFS=";" read -r home_team guest_team outcome; do
        [[ -z "$home_team" ]] && break

        echo "$home_team;$outcome"
        echo "$guest_team;${opposite[$outcome]}"
    done
}

tally() {
    local current_team team outcome
    local played win draw loss points

    while IFS=";" read -r team outcome; do
        if [[ $current_team != "$team" ]]; then
            [[ -n $current_team ]] && echo "$current_team;$played;$win;$draw;$loss;$points"

            current_team="$team"
            played=0; win=0; draw=0; loss=0; points=0
        fi

        (( played += 1 ))
        (( ${outcome} += 1 ))
        (( points += outcome_points[$outcome] ))
    done

    [[ -n $current_team ]] && echo "$current_team;$played;$win;$draw;$loss;$points"
}

print_out() {
    local fields

    while IFS=";" read -ra fields; do
        printf "$row_pattern" "${fields[@]}"
    done
}

printf "$row_pattern" Team MP W D L P

expand_data | sort | tally | sort -t ';' -k 6,6nr -k 1,1 | print_out
