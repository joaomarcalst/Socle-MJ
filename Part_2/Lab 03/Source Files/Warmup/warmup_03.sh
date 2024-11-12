#!/bin/bash
# Prints integers between a given range (min and max)

if [ $# -ne 2 ]; then
    echo "Please provide exactly two arguments (min and max)."
    exit 1
fi

min=$1
max=$2

if [ "$min" -ge "$max" ]; then
    echo "Error: min must be less than max."
    exit 2
fi

for i in $(seq "$min" "$max"); do
    echo "$i"
done