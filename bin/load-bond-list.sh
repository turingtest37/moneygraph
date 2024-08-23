#! /bin/sh
# Runs a 

sh ./bond-list.sh $1 $2
if test "$2" == "debug"
then
    exit 0
fi
sh ./add-simulated-bond-price.sh
