#! /bin/sh

FILE=`realpath $1`

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMED_GRAPH=https://triples.beesondouglas.com/questrade/__activities__
NAMEBASE=activities
QUERY=$PROJBASE/$NAMEBASE.rq
OUT=$PROJBASE/out/$NAMEBASE.nt
UPLOAD=$PROJBASE/out/$NAMEBASE-1.nt
OUTOPT="-o ${OUT}"
FORMAT="NT"

if test "$2" == "debug"
then
    echo "Debug mode. No data will be uploaded."
    DEBUG=true
    FORMAT="TTL"
    OUTOPT=""
fi

# Clear the named graph
# curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NAMED_GRAPH}>" "${SERVER}"

# Generate RDF from the input file
# java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f NT -o "${OUT}" -v loc="${FILE}"
java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f ${FORMAT} ${OUTOPT} -v loc="${FILE}"
if test "xDEBUG" == "x"
then 
# Upload to a named graph
curl -i -H "Content-Type: application/n-triples" --data-binary @"${UPLOAD}" --url-query "context=<${NAMED_GRAPH}>" "${SERVER}"
echo "Done uploading"
fi

