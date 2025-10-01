#!/usr/bin/env bash

num=$1

#        000  001   010   011        100   101        110        111
outputs=("$1" Pling Plang PlingPlang Plong PlingPlong PlangPlong PlingPlangPlong) 

echo "${outputs[$(( !(num % 7) * 4 + !(num % 5) * 2 + !(num % 3) ))]}"
