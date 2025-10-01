#!/usr/bin/env bash

n_flag=false
l_flag=false
i_flag=false
v_flag=false
x_flag=false

declare -a files

for param in "$@"; do
    if [[ $param == -[a-z] ]]; then
        declare "${param:1}"_flag=true    # -n => n_flag , etc...
    elif [[ $param == -* ]]; then
        echo "Invalid option: $param" >&2
        continue
    elif [[ ! -v pattern ]]; then
        pattern="$param"
    else
        files+=( "$param" )
    fi
done

$i_flag && shopt -s nocasematch

! $x_flag && pattern="*${pattern}*"

is_match() {
 (! $v_flag && [[ $line == $pattern ]]) ||
 ($v_flag && [[ $line != $pattern ]])  
}

file_count=${#files[@]}

for file_name in "${files[@]}"; do
    line_number=0
    while IFS= read -r line; do
        (( line_number++ ))

        if is_match; then
            if $l_flag ; then    # print just the file names
                echo "$file_name"
                break
            fi
            
            (( file_count > 1 )) && printf '%s:' "$file_name"
            $n_flag && printf '%s:' "$line_number"
            printf '%s\n' "$line"
        fi
    done < "$file_name"
done
