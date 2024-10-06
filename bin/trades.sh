#! /bin/sh

#! /bin/sh

FILE=`realpath $1`
echo "Processing ${FILE}..."

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMEBASE=trades
NAMED_GRAPH="https://w3id.org/moneygraph/ns/data/__${NAMEBASE}__"
QUERY=$PROJBASE/tarql/$NAMEBASE.rq
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

# Generate RDF from the input file
java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f ${FORMAT} ${OUTOPT} -v loc="${FILE}"

# Clear the named graph
if test "$2" == "clear"
then 
    echo "Clearing graph ${NAMED_GRAPH}..."
    curl -fsSL -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NAMED_GRAPH}>" "${SERVER}"
    echo "Uploading to named graph ${NAMED_GRAPH}..."
    curl -fsSL -H "Content-Type: application/n-triples" --data-binary @"${UPLOAD}" --url-query "context=<${NAMED_GRAPH}>" "${SERVER}"
    echo "Done uploading"
fi

if test "x$2" == "x"
then
    # Upload to a named graph
    echo "Uploading to named graph ${NAMED_GRAPH}..."
    curl -fsSL -H "Content-Type: application/n-triples" --data-binary @"${UPLOAD}" --url-query "context=<${NAMED_GRAPH}>" "${SERVER}"
    echo "Done uploading"
fi
