#!/usr/bin/env bash

n_flag=false
l_flag=false
i_flag=false
v_flag=false
x_flag=false

while getopts ":nlivx" opt;  do
    case $opt in
        [nlivx]) declare "${opt}_flag"=true ;;
        \?) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done
shift $((OPTIND - 1))   # these are the processed options
if (( $# == 0 )); then
    echo "Usage"
fi
pattern=$1
files=( "${@:2}" )

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
