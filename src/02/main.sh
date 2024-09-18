#!/bin/bash
TIME_SRT=$(date +%H:%M:%S)
START_M=$(date +%s%N) && START_S=$(date +%s)
if [ -n "$1" ]; then
  if [ $# -ne 3 ]; then
    echo "The number of parameters is not equal to 3"
  else
    if [[ ! $1 =~ ^[a-zA-Z]{1,7}$ ]]; then
      echo "Invalid directory name"
    elif [[ ! $2 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
      echo "Invalid file name"
    elif [[ ! $3 =~ ^[0-9]{1,3}Mb$ ]]; then
      echo "Invalid file size"
    else
      LAST=`echo $3 | sed 's/..$//'`
      if [ $LAST -gt 100 ]; then
        echo "File size must be 100 or less"
      else
        chmod +x if_valid.sh && ./if_valid.sh $@
	END_M=$(date +%s%N)
	END_S=$(date +%s)
	DIFF_M=$((($END_M - $START_M)/10000000))
	DIFF_S=$(( $END_S - $START_S ))
	echo "Script start time = $TIME_SRT"
	echo "Script end time = $(date +%H:%M:%S)"
	echo "Script execution time (in seconds) = $DIFF_S.$DIFF_M"
      fi
    fi
  fi
else
  echo "No parameters found"
fi

