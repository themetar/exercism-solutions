#!/usr/bin/env bash

declare -a files

for param in "$@"; do
    if [[ $param == -* ]]; then
        declare "${param:1}"_flag=1    # -n => n_flag , etc...
    elif [[ ! -v pattern ]]; then
        pattern="$param"
    else
        files+=( "$param" )
    fi
done

[[ "$i_flag" ]] && shopt -s nocasematch

file_count=${#files[@]}

for file_name in "${files[@]}"; do
    line_number=0
    while read -r line; do
        (( line_number++ ))

        [[ ! "$x_flag" && $line == *"$pattern"* || "$x_flag" && $line == "$pattern" ]]    # test matching
        match=$?    # store result

        [[ "$v_flag" ]] && (( match = !match ))    # invert match if flag is set

        if (( $match == 0 )); then
            if [[ "$l_flag" ]]; then    # print just the file names
                echo "$file_name"
                break
            fi
            
            (( file_count > 1 )) && printf '%s:' "$file_name"
            [[ "$n_flag" ]] && printf '%s:' "$line_number"
            printf '%s\n' "$line"
        fi
    done < "$file_name"
done
