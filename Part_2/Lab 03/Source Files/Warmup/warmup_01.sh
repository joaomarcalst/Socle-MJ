#!/bin/bash

echo "Number of parameters: $#"

if [ $# -gt 0 ]; then
  echo "List of parameters:"
  for param in "$@"; do
    echo "$param"
  done
else
  echo "No parameters provided."
fi