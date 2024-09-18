#!/bin/bash
REG=`pwd | sed "s/\/src\/02//"`
find / -type d -perm -u+w -not -regex "^$REG.*" 2>/dev/null | grep -vi bin > paths.txt
SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
NUMB_DIR=$(($RANDOM%99+1)) && WC=`cat paths.txt | wc -l`
SYMB_F=`echo $1 | grep -o -e "^."` && SYMB_L=`echo $1 | grep -o -e ".$"`
RAND_DIR=$(($RANDOM%$WC+1)) && RAND_NUMB=$(($RANDOM%99+1))
DATE=`date +%d%m%y` && OLD_WAY=`cat paths.txt | head -n$RAND_DIR | tail -n1`

if [[ $SYMB_F == $SYMB_L ]] && [ ${#1} -ne 1 ]; then
  for i in `echo $1 | grep -o -e "."`; do  # поиск символа отличающегося от последнего
    if [[ ! $i == $SYMB_L ]]; then
      SYMB_F=$i && break
    fi
  done
fi

while [ ${#DIR_NAME} -lt 5 ]; do  # подгон имени папки под 5 знаков 
  DIR_NAME+=$SYMB_L
done

chmod +x clogging.sh && echo -e "\nFolders" > folders.txt && echo Files > data.log
while [[ $SPACE == G ]]; do  # пока свободно места больше 1 гига
  DIR_NAME=$1 && J=1 && NO=0
  for (( i=0; i<$NUMB_DIR; i++ )); do  # создание вложенных папок в случайно указанном месте
    WAY="$OLD_WAY/" && WAY+=$DIR_NAME && WAY+="_$DATE/"
    mkdir $WAY
    if [ ! -d $WAY ]; then  #  если папка не создалась
      continue
    fi
    echo "`date +%d.%m.%Y` $WAY" >> folders.txt
    ./clogging.sh $WAY $2 $3 $RAND_NUMB  #  засорение папки файлами
    if [[ `echo $DIR_NAME | grep -o -i $SYMB_L | wc -l` -gt 1 ]] &&
       [[ $(( `echo `$J/6``%2 )) -eq 1 ]] && [[ ! $SYMB_F == $SYMB_L ]]; then  # генерирование нового имени
      DIR_NAME=`echo $DIR_NAME | sed "s/$SYMB_L/$SYMB_F/2"`
    else
      DIR_NAME+=$SYMB_L
    fi
    let J++ && SPACE=`df -h / | tail -n1 | awk '{print $4}' | grep -o -e ".$"`
    if [[ $SPACE == M ]]; then
      NO=1 && break
    fi
  done
  if [ $NO -eq 1 ]; then 
    break
  fi
  RAND_DIR=$(($RANDOM%$WC+1)) && RAND_NUMB=$(($RANDOM%99+1))
  OLD_WAY=`cat paths.txt | head -n$RAND_DIR | tail -n1`
done
cat folders.txt >> data.log && rm -rf paths.txt folders.txt
