#!/usr/bin/env bash

declare -A plants=([G]=grass [C]=clover [R]=radishes [V]=violets)

garden=( $(IFS=$'\n'; echo $1) )

first_letters=({A..L})
for index in "${!first_letters[@]}"; do
  if [[ "${first_letters[index]}" = ${2:0:1} ]]; then break; fi
done
((garden_index = index * 2))

echo "${plants[${garden[0]:garden_index:1}]} ${plants[${garden[0]:garden_index+1:1}]} ${plants[${garden[1]:garden_index:1}]} ${plants[${garden[1]:garden_index+1:1}]}"
