#! /bin/sh
FILE=`realpath $1`

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMEBASE=valuation
NAMED_GRAPH_BASE="https://triples.beesondouglas.com/questrade/__${NAMEBASE}__"
QUERY=$PROJBASE/$NAMEBASE.rq
OUT=$PROJBASE/out/$NAMEBASE.nt
UPLOAD=$PROJBASE/out/$NAMEBASE-1.nt
CURRENT_GRAPH="${NAMED_GRAPH_BASE}latest"
TODAY_GRAPH="${NAMED_GRAPH_BASE}`date -I`"
OUTOPT="-o ${OUT}"
FORMAT="NT"

if test "$2" == "debug"
then
    echo "Debug mode. No data will be uploaded."
    DEBUG=true
    FORMAT="TTL"
    OUTOPT=""
fi

echo "Processing ${FILE} with ${QUERY}..."
java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f ${FORMAT} ${OUTOPT} -v loc="${FILE}"

if test "x$2" == "x"
then 
# echo $NAMED_GRAPH
echo "Uploading to ${TODAY_GRAPH}..."
curl -i -v -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<${TODAY_GRAPH}>" "$SERVER"

echo "Clearing ${CURRENT_GRAPH}..."
curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${CURRENT_GRAPH}>" "$SERVER"

echo "Uploading to ${CURRENT_GRAPH}..."
curl -i -v -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<$CURRENT_GRAPH>" "$SERVER"
fi

echo "Done."
