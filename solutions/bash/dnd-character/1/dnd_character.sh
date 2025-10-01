#!/usr/bin/env bash

roll() {
    echo "$(( RANDOM % 6 + 1 ))"
}

dice_roll() {
    local a b c tmp rnd=$(roll)
    if (( (a = $(roll)) < rnd )); then tmp=$a; a=$rnd; rnd=$tmp; fi
    if (( (b = $(roll)) < rnd )); then tmp=$b; b=$rnd; rnd=$tmp; fi
    if (( (c = $(roll)) < rnd )); then tmp=$c; c=$rnd; rnd=$tmp; fi
    echo "$(( a + b + c ))"
}

case $1 in
    modifier)
        value=$(( $2 - 10 ))
        echo "$(( value < 0 && value % 2 != 0 ? value / 2 - 1 : value / 2 ))"
    ;;
    generate)
        constitution=$(dice_roll) 
        echo "strength $(dice_roll)"
        echo "dexterity $(dice_roll)"
        echo "constitution $constitution"
        echo "intelligence $(dice_roll)"
        echo "wisdom $(dice_roll)"
        echo "charisma $(dice_roll)"
        echo "hitpoints $(( 10 + $(./dnd_character.sh modifier $constitution) ))"
    ;;
esac
