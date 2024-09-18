#!/bin/bash
YEAR1=`echo $1 | grep -o -e "^...."` && YEAR2=`echo $3 | grep -o -e "^...."`
MONTH1=`echo $1 | grep -o -e "-..-"` | sed 's/-//g'
MONTH2=`echo $3 | grep -o -e "-..-"` | sed 's/-//g'
DAY1=`echo $1 | grep -o -e "..$"` && DAY2=`echo $3 | grep -o -e "..$"`
if [[ ! $1 =~ ^202[2-9]-(0?[1-9]|1[0-2])-([0-2]?[0-9]|3[0-1])$ ||
      ! $3 =~ ^202[2-9]-(0?[1-9]|1[0-2])-([0-2]?[0-9]|3[0-1])$ ]]; then
  echo "Invalid date"
elif [[ ! $2 =~ ^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$ ||
        ! $4 =~ ^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
  echo "Invalid time"
elif [[ $YEAR1 -gt $YEAR2 ]]; then
  echo "Start year must be earlier or equal than end year"
elif [[ $YEAR1 -eq $YEAR2 && 
	$MONTH1 -gt $MONTH2 ]]; then
  echo "Start month must be earlier than end month"
elif [[ $YEAR1 -eq $YEAR2 &&
        $MONTH1 -eq $MONTH2 && 
	$DAY1 -gt $DAY2 ]]; then
  echo "Start day must be earlier than end day"
elif [ `echo $2 | grep -o -e "^.."` -gt `echo $4 | grep -o -e "^.."` ]; then
  echo "Start time must be earlier than end time"
elif [ `echo $2 | grep -o -e "^.."` -eq `echo $4 | grep -o -e "^.."` ] &&
     [ `echo $2 | grep -o -e "..$"` -gt `echo $4 | grep -o -e "..$"` ]; then
  echo "Start time must be earlier than end time (min)"
elif [ `echo $2 | grep -o -e "^.."` -eq `echo $4 | grep -o -e "^.."` ] &&
     [ `echo $2 | grep -o -e "..$"` -eq `echo $4 | grep -o -e "..$"` ]; then
  echo "Start time must be different from end time"
else
  REG=`pwd | sed "s/\/src\/03//"`
  find / -type d -newermt "$1 $2" ! -newermt "$3 $4" -not -regex "^$REG.*" -exec rm -rf {} \;
fi
