#!/bin/bash

echo -e "** This data was collected from March 15th \n" >> Dealers_working_during_losses.txt
## Searching for roulette dealers involved in hours with losses on March 15th. 
## Data referenced is in ../Notes_Player_Analysis.txt.
echo $(grep -i "hour" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}') >> Dealers_working_during_losses.txt

## 05:00:00 AM
echo $(grep -i "05:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}') >> Dealers_working_during_losses.txt
## 08:00:00 AM
echo $(grep -i "08:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}') >> Dealers_working_during_losses.txt
## 02:00:00 PM
echo $(grep -i "02:00:00 PM" 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}') >> Dealers_working_during_losses.txt

echo "" >> Dealers_working_during_losses.txt