#!/bin/bash
# Prints a sequence of integers based on the number of arguments

if ! [[ "$min" =~ ^-?[0-9]+$ ]] || ! [[ "$max" =~ ^-?[0-9]+$ ]] || ! [[ "$step" =~ ^-?[0-9]+$ ]]; then
    echo "Error: All arguments must be integers."
    exit 3
fi
if [ $# -eq 0 ]; then
    echo "No arguments provided. Outputting default sequence (1 to 10)."
    seq 1 10
    exit 1
elif [ $# -eq 1 ]; then
    max=$1
    seq 1 "$max"
    exit 0
elif [ $# -eq 2 ]; then
    min=$1
    max=$2
    if [ "$min" -ge "$max" ]; then
        echo "Error: min must be less than max."
        exit 2
    fi
    seq "$min" "$max"
    exit 0
else
    echo "Too many arguments."
    exit 1
fi