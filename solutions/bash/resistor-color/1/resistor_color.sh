#!/usr/bin/env bash

colors=( black brown red orange yellow green blue violet grey white )

case $1 in
    code )
        for index in "${!colors[@]}"; do
            if [[ "${colors[index]}" == "$2" ]]; then
                echo "$index"
                exit 0
            fi
        done
    ;;
    colors )
        IFS=$'\n'
        echo "${colors[*]}"
    ;;
esac
