########################################################################
#  Sergey Brazgin     05.2018    IAC.DZM
# mail:   sbrazgin@gmail.com
######################################################################## 

#!/bin/bash
# params: 1) dir 2) files



if [ "$#" -ne 2 ]; then
  echo "Usage: $0 DIRECTORY_NAME LOGS_NAME" >&2
  exit 1
fi

if ! [ -d "$1" ]; then
  echo "ERROR: $1 not a directory" >&2
  exit 1
fi

timestamp=$(date +%Y%m%d_%H%M%S)
path="$1"
filename=log_delete_$timestamp.txt
log=$path/$filename


echo "-----------------------------------------------------" >> $log
echo "$(date +%Y%m%d_%H%M%S) Start" >> $log

#part 1
echo "$(date +%Y%m%d_%H%M%S) Delete files:" >> $log
## DELETE older 1 day
find $path -name "$2*log*"  -type f -mtime +1 -print  >> $log
find $path -name "$2*log*"  -type f -mtime +1 -delete 


# part 2
echo "$(date +%Y%m%d_%H%M%S) GZIP files:" >> $log
## GZIP older 4 hour
find $path -name "$2*log" -mmin +120 -type f -print  >> $log
find $path -name "$2*log" -mmin +120 -type f -exec gzip {} \;


# END
echo "$(date +%Y%m%d_%H%M%S) End" >> $log
echo "-----------------------------------------------------" >> $log



