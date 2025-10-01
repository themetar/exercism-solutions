#!/usr/bin/env bash

declare -A pairs=( ["["]="]" ["{"]="}" ["("]=")" )

declare -a brackets

for (( idx = 0, len = ${#1}; idx < len; ++idx )); do
    case "${1:idx:1}" in
    \[|\{|\()
        brackets+=( "${pairs[${1:idx:1}]}" )
        ;;
        
    \]|\}|\))
        if (( ${#brackets[@]} == 0 )) || [[ "${1:idx:1}" != ${brackets[-1]} ]]; then
            echo false
            exit 0
        fi

        unset brackets[-1]     
        ;;
    esac
done

(( ${#brackets[@]} == 0 )) && echo true || echo false
