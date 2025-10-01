#!/usr/bin/env bash

main () {
  printf '%(%Y-%m-%dT%H:%M:%S)T\n' $(($(date -d $1 +%s) + 1000000000))
}

main "$@"
