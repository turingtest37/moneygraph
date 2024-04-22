#! /bin/sh

FILE=$1

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMED_GRAPH=https://triples.beesondouglas.com/questrade/__activities__
NAMEBASE=activities
QUERY=$PROJBASE/$NAMEBASE.rq
OUT=$PROJBASE/out/$NAMEBASE.nt
UPLOAD=$PROJBASE/out/$NAMEBASE-1.nt

curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NAMED_GRAPH}>" "${SERVER}"

java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f NT -o "${OUT}" -v loc="${FILE}"

curl -i -v -H "Content-Type: application/n-triples" --data-binary @"${UPLOAD}" --url-query "context=<${NAMED_GRAPH}>" "${SERVER}"
