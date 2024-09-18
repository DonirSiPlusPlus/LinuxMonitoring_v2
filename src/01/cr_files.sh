#!/bin/bash
SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
TEMP_NAME=`echo $5 | grep -o -e ".*\." | sed 's/.$//'`
SYMB_F=`echo $TEMP_NAME | grep -o -e "^."` && SYMB_L=`echo $TEMP_NAME | grep -o -e ".$"`
EXTENSION=`echo $5 | grep -o -e "\..*"`
DATE=`date +%d%m%y` && SIZE=`echo $6 | sed 's/kb/K/'`

while [ ${#TEMP_NAME} -lt 4 ]; do
  TEMP_NAME+=$SYMB_L
done

if [[ $SYMB_F == $SYMB_L ]] && [ ${#TEMP_NAME} -gt 1 ]; then
  for i in `echo $TEMP_NAME | grep -o -e "."`; do
    if [[ ! $i == $SYMB_L ]]; then
      SYMB_F=$i && break
    fi
  done
fi

echo -e "\nFiles" >> data.log
for DIR in `cat data.log | head -n$(($2 + 1)) | tail -n$2 | awk '{print $2}'`; do
  J=1 && DIR+=/
  for (( i=0; i<$4; i++ )); do
    if [[ $SPACE == M ]]; then
      echo "No disk space left" && NO=1 && break
    fi
    FILENAME=$DIR$TEMP_NAME && FILENAME+=_ && FILENAME+=$DATE$EXTENSION
    fallocate -l $SIZE $FILENAME
    echo "`date +%d.%m.%Y` $6 $FILENAME" >> data.log
    if [[ `echo $TEMP_NAME | grep -o -i $SYMB_L | wc -l` -gt 1 ]] &&
       [[ $(( `echo `$J/10``%2 )) -eq 1 ]] && [[ ! $SYMB_F == $SYMB_L ]]; then
      TEMP_NAME=`echo $TEMP_NAME | sed "s/$SYMB_L/$SYMB_F/2"`
    else
      TEMP_NAME+=$SYMB_L
    fi
    let J++ && SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
  done
  TEMP_NAME=`echo $5 | grep -o -e ".*\." | sed 's/.$//'`
done

