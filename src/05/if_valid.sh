#!/bin/bash
LOGI="../04/web*"
if [ $1 -eq 1 ]; then
  awk '{print $0}' $LOGI | sort -k 9
elif [ $1 -eq 2 ]; then
  awk '{print $1}' $LOGI | uniq 
elif [ $1 -eq 3 ]; then
  awk '$9 >= 400 {print $0}' $LOGI
elif [ $1 -eq 4 ]; then
  awk '$9 >= 400 {print $1}' $LOGI | uniq 
fi
