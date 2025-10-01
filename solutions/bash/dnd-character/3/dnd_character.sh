#!/usr/bin/env bash

roll() {
    echo "$(( RANDOM % 6 + 1 ))"
}

dice_roll() {
    local sum min rnd
    sum=0
    for __ in {1..4}; do
        rnd=$(roll)
        [[ ! -v $min || $rnd -lt $min ]] && min=$rnd
        (( sum += rnd ))
    done
    echo "$(( sum - min ))"
}

modifier() {
    local value
    value=$(( $1 - 10 ))
    (( value < 0 && (value -= 1) )) 
    echo "$(( value / 2 ))"
}

generate() {
    local constitution
    constitution=$(dice_roll) 
    echo "strength $(dice_roll)"
    echo "dexterity $(dice_roll)"
    echo "constitution $constitution"
    echo "intelligence $(dice_roll)"
    echo "wisdom $(dice_roll)"
    echo "charisma $(dice_roll)"
    echo "hitpoints $(( 10 + "$(modifier "$constitution")" ))"
}

"$1" "${@:2}"
