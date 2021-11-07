#!/bin/bash


## Check if user forgot to input arguments when running script.
if [ $# -eq 0 ]; then
    ## check here.
    exit 1
fi

echo -e "Fetching schedule data from $1 at $2 $3 \n"

echo $(grep -i "hour" 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}') 

cat $1_Dealer_schedule | grep -i $2 | grep -i $3 | awk -F" " '{print $1, $2, $5, $6}'
