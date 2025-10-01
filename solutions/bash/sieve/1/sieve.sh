#!/usr/bin/env bash

max=$1
sieve=(0 0 0)
primes=""

for (( i=2; i <= max; i++ )); do
    if [[ ${sieve[i]} != $i ]]; then
        primes="$primes $i"
        for (( p=2; i * p <= max; p++ )); do
            n=$((i * p))
            sieve[i * p]=$n
        done
    fi
done

echo $primes
