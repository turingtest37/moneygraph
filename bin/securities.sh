#! /bin/sh
FILE=$1

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMED_GRAPH_BASE=https://triples.beesondouglas.com/questrade/__securities__
NAMEBASE=securities
QUERY=$PROJBASE/$NAMEBASE.rq
OUT=$PROJBASE/out/$NAMEBASE.nt
UPLOAD=$PROJBASE/out/$NAMEBASE-1.nt

CURRENT_GRAPH="${NAMED_GRAPH_BASE}"

echo "Processing ${FILE} with ${QUERY}" 
java -jar ~/dev/sparql-anything-0.8.2.jar -q "$QUERY" -f NT -o "$OUT" -v loc="$FILE"

TODAY_GRAPH="${NAMED_GRAPH_BASE}`date -I`"
# echo $NAMED_GRAPH
curl -i -v -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<${TODAY_GRAPH}>" "$SERVER"

curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${CURRENT_GRAPH}>" "$SERVER"

curl -i -v -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<$CURRENT_GRAPH>" "$SERVER"

