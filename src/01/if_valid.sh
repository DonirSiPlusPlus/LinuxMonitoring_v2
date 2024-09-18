#!/bin/bash
SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
DIR_NAME=$3
SYMB_F=`echo $3 | grep -o -e "^."` && SYMB_L=`echo $3 | grep -o -e ".$"`
DATE=`date +%d%m%y`

while [ ${#DIR_NAME} -lt 4 ]; do
  DIR_NAME+=$SYMB_L
done

if [[ $SYMB_F == $SYMB_L ]] && [ ${#3} -ne 1 ]; then 
  for i in `echo $3 | grep -o -e "."`; do
    if [[ ! $i == $SYMB_L ]]; then
      SYMB_F=$i && break
    fi
  done
fi

J=1 && NO=0 && echo Folders > data.log
for (( i=0; i<$2; i++ )); do
  if [[ $SPACE == M ]]; then
    echo "No disk space left" && NO=1 && break
  fi
  WAY=$1
  if [[ `echo $1 | grep -o -e ".$"` != "/" ]]; then
    WAY+="/"
  fi
  WAY+=$DIR_NAME && WAY+="_$DATE" && mkdir $WAY
  echo "`date +%d.%m.%Y` $WAY" >> data.log
  if [[ `echo $DIR_NAME | grep -o -i $SYMB_L | wc -l` -gt 1 ]] &&
     [[ $(( `echo `$J/5``%2 )) -eq 1 ]] && [[ ! $SYMB_F == $SYMB_L ]]; then
    DIR_NAME=`echo $DIR_NAME | sed "s/$SYMB_L/$SYMB_F/2"`
  else
    DIR_NAME+=$SYMB_L
  fi
  let J++ && SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
done

if [ $NO -eq 0 ]; then
  bash ./cr_files.sh $@
fi

