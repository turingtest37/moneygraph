#! /bin/sh

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMEBASE=add-simulated-bond-price
QUERY=${PROJBASE}/queries/${NAMEBASE}.rq
CURRENT_GRAPH=https://triples.beesondouglas.com/questrade/__bondlist__extras

if test "$1" == "debug"
then
    echo "Debug mode. No data will be uploaded."
    cat ${QUERY}
fi

if test "x$1" == "x"
then 
echo "Clearing old graph and inserting new info..."


echo "Clearing ${CURRENT_GRAPH}..."
curl -i -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${CURRENT_GRAPH}>" "$SERVER"

curl -i -H "Content-Type: application/sparql-update" --data-binary @"${QUERY}" "$SERVER"
fi

echo "Done."