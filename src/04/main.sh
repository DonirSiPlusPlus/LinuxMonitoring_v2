#!/bin/bash
ANSW=(200 201 400 401 403 404 500 501 502 503)
#200 все ок; 201 все ок ресурс создан; 
#400 ошибка синтаксиса; 401 не хватает данных; 403 отказ авторизации; 404 ресурс не найден;
#500 непредвиденная ошибка; 501 запрос не поддерживается сервером; 502 сервер получил неверный ответ; 503 сервер не готов обработать запрос
MEDS=(GET POST PUT PATCH DELETE)
AGENT=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
URS=("youtube.com" "vk.com" "habr.com" "gosuslugi.ru" "rutube.ru" "ya.ru" "google.com" "hh.ru" "ufc.ru" "sber.ru")
ZONE=`timedatectl | awk '{print $5}' | head -n4 | tail -n1 | sed 's/)//'`

for ((i=4; i>=0; i-- )); do
  RECS=$(($RANDOM%901+100))
  DAY=`date +/%b/%Y:` && DAY+="$((10+$i)):"
  DATE=`date +%d` && DATE=$(($DATE-$i))
  if [ $DATE -lt 1 ]; then
    DATE=1
  fi
  DATE+=$DAY
  echo -n > web$((5-$i)).log
  for ((j=0; j<$RECS; j++)); do
    MIN="$(($RANDOM%6))$(($RANDOM%10)):" && SEC="$(($RANDOM%6))$(($RANDOM%10))"
    IP="$(($RANDOM%256)).$(($RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
    CODE=$(($RANDOM%10)) && CODE=${ANSW[$CODE]}
    METHOD=$(($RANDOM%5)) && METHOD=${MEDS[$METHOD]}
    URL=$(($RANDOM%10)) && URL=${URS[$URL]}
    BROWS=$(($RANDOM%8)) && BROWS=${AGENT[$BROWS]}
    echo "$IP - - [$DATE$MIN$SEC $ZONE] \"$METHOD $URL HTTP/2.0\" $CODE - \"_\" \"$BROWS\"" >> web$((5-$i)).log
  done
done
