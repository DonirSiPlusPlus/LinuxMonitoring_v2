#!/bin/bash
LOG_FILE="../02/data.log"
if [ $1 -eq 1 ]; then
  F_STR=`grep -n Folders $LOG_FILE | sed "s/:.*//"`
  WC=`cat $LOG_FILE | wc -l`
  for DIR in `cat $LOG_FILE | tail -n$(($WC-$F_STR)) | awk '{print $2}'`; do
    rm -rf $DIR
  done
elif [ $1 -eq 2 ]; then
  echo -n "Enter the start date of the period in the format \"yyyy-mm-dd\": " && read ST_DATE
  echo -n "Enter the start time in the format \"hh:mm\": " && read ST_TIME
  echo -n "Enter the end date of the period in the format \"yyyy-mm-dd\": " && read END_DATE
  echo -n "Enter the start time in the format \"hh:mm\": " && read END_TIME
  bash del_by_time.sh $ST_DATE $ST_TIME $END_DATE $END_TIME
elif [ $1 -eq 3 ]; then
  TODAY=`date +%d%m%y`
  echo -n "Enter a directory name pattern: " && read NAME
  S1=${NAME:0:1} && S2=${NAME:1:1} && S3=${NAME:2:1}
  S4=${NAME:3:1} && S5=${NAME:4:1} && S6=${NAME:5:1}
  S7=${NAME:6:1}
  if [[ ! $NAME =~ ^[a-zA-Z]{1,7}$ ]]; then
    echo "Invalid directory name"
  else
    find / -type d -regex ".*/$S1*$S2*$S3*$S4*$S5*$S6*$S7*.*_$TODAY.*" -exec rm -rf {} \;
  fi
fi
