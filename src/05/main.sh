#!/bin/bash
if [ -n "$1" ]; then
  if [ $# -gt 1 ]; then
    echo "Too many parameters"
  elif [[ ! $1 =~ [1-4] ]]; then
    echo "Invalid paremeter"
  else
    bash if_valid.sh $@
  fi
else
  echo "No parameters found"
fi
