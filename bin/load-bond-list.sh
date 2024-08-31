#! /bin/sh
# Runs a 

PROJBASE=/Users/doug/dev/moneygraph

sh "${PROJBASE}/bin/bond-list.sh" $1 $2
if test "$2" == "debug"
then
    exit 0
fi
sh "${PROJBASE}/bin/add-simulated-bond-price.sh"
