#!/bin/bash
HELC="# HELP avail_cpu Activity of CPU."
TYPC="# TYPE avail_cpu counter"
HELR="# HELP avail_ram Avail mem ram in Mb."
TYPR="# TYPE avail_ram gauge"
HELS="# HELP avail_space Avail disk space in Mb."
TYPS="# TYPE avail_space gauge"

PAT="/tmp/www/metrics"
if [ ! -d $PAT ]; then
  mkdir /tmp/www/ && mkdir $PAT
fi

while true; do
  CPU=0 
  for (( i=0; i<2; i++)); do
    J=0
    for I in `cat /proc/stat | head -n1`; do
      (( J++ ))
      if [ $J -gt 1 ]; then
        if [ $J -ne 5 ] && [ $J -ne 6 ]; then
          CPU=$(($CPU+$I))
        fi
      fi
    done
  done
  RAM=`awk '{print $2}' /proc/meminfo | head -n2 | tail -n1` && RAM=$(($RAM/1024))
  SPACE=`df -m / | tail -n1 | awk '{print $4}'`
  echo $HELC > index.html && echo $TYPC >> index.html && echo "avail_cpu $CPU" >> index.html
  echo $HELR >> index.html && echo $TYPR >> index.html && echo "avail_mem $RAM" >> index.html
  echo $HELS >> index.html && echo $TYPS >> index.html && echo "avail_space $SPACE" >> index.html
  cp index.html $PAT
  sleep 4
done
