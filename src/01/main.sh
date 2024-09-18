#!/bin/bash
if [ -n "$1" ]; then
  if [ $# -ne 6 ]; then
    echo "The number of parameters is not equal to 6"
  else
    if [ ! -d $1 ]; then
      echo "$1 - Directory doesn't exist"
    elif [[ ! $1 =~ ^/.* ]]; then
      echo "Path must be absolute"
    elif [[ ! $2 =~ ^[0-9]*$ ]]; then
      echo "Incorrect number of subfolders"
    elif [[ ! $3 =~ ^[a-zA-Z]{1,7}$ ]]; then
      echo "Invalid characters in folder names"
    elif [[ ! $4 =~ ^[0-9]*$ ]]; then
      echo "Incorrect number of files"
    elif [[ ! $5 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
      echo "Invalid characters in filename"
    elif [[ ! $6 =~ ^[0-9]{1,3}kb$ ]]; then
      echo "Invalid characters in file size"
    else
      SIZE=`echo $6 | sed 's/..$//'`
      if [ $SIZE -gt 100 ]; then
        echo "File size must be less or equal than 100"
      else
        bash if_valid.sh $@
      fi
    fi
  fi
else
  echo "No parameters found"
fi

