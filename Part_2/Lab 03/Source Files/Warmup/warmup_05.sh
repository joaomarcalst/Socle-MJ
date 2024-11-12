#!/bin/bash
# Prints a sequence with optional step value.

min=1
max=10
step=1

# Integer verification
is_integer() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

# No argument provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Default sequence  (1 - 10)"
    seq "$min" "$max"
    exit 1

# One argument provided
elif [ $# -eq 1 ]; then
    max=$1
    if is_integer "$max"; then
        seq "$min" "$max"
        exit 0
    else
        echo "Error: Argument must be an integer."
        exit 3
    fi

# Two arguments provided
elif [ $# -eq 2 ]; then
    min=$1
    max=$2
    if is_integer "$min" && is_integer "$max"; then
        if [ "$min" -ge "$max" ]; then
            echo "Error: min must be less than max."
            exit 2
        fi
        seq "$min" "$max"
        exit 0
    else
        echo "Error: Both arguments must be integers."
        exit 3
    fi

# Three arguments provided (Step)
elif [ $# -eq 3 ]; then
    min=$1
    max=$2
    step=$3
    if is_integer "$min" && is_integer "$max" && is_integer "$step"; then
        if  [ "$min" -ge "$max" ]; then
            echo "Erro: min must be less than max."
            exit 2
        fi
        seq "$min" "$step" "$max"
        exit 0
    else
        echo "Error: All arguments must be integers."
        exit 3
    fi
# More than three arguments
else
    echo "Too many arguments. Expected at most 3."
    exit 1
fi