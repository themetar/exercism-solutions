#!/usr/bin/env bash

[[ $# -ne 1 || $1 =~ [^0-9] ]] && { echo "Usage: leap.sh <year>" >&2; exit 1; }

(( $1 % 4 == 0 && ($1 % 100 != 0 || $1 % 400 == 0) )) && echo true || echo false
