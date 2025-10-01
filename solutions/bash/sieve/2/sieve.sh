#!/usr/bin/env bash

max=$1
sieve=()
primes=()

for (( i = 2; i <= max; i++ )); do
    if [[ ${sieve[i]} != "$i" ]]; then
        primes+=($i)
        for (( n = i + i ; n <= max; n += i )); do
            sieve[n]=$n
        done
    fi
done

echo "${primes[@]}"
