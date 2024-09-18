#!/bin/bash
if [ -n "$1" ]; then
  LOG_FILE="../02/data.log"
  if [[ $# -gt 1 ]]; then
    echo "The number of parameters is not equal to 1"
  elif [[ ! $1 =~ ^[1-3]$ ]]; then
    echo "Invalid parameter"
  elif [ $1 -eq 1 ] && [ ! -f $LOG_FILE ]; then
    echo "Log file doesn't exist"
  else
    bash if_valid.sh $1
  fi
else
  echo "No parameters found"
fi
