#! /bin/sh

FILE=`realpath $1`
echo "Processing ${FILE}..."

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMEBASE=securities
NAMED_GRAPH_BASE="https://w3id.org/moneygraph/ns/data/__${NAMEBASE}__"
QUERY=$PROJBASE/tarql/$NAMEBASE.rq
OUT=$PROJBASE/out/$NAMEBASE.nt
UPLOAD=$PROJBASE/out/$NAMEBASE-1.nt
CURRENT_GRAPH="${NAMED_GRAPH_BASE}"
echo "CURRENT_GRAPH=$CURRENT_GRAPH"
ARCHIVE_GRAPH="${NAMED_GRAPH_BASE}archive"
echo "ARCHIVE_GRAPH = $ARCHIVE_GRAPH"
# Extract date from $FILE using sed or awk; use that date for ARCHIVE_GRAPH
FILEDATE=`basename $FILE | sed 's/[^0-9]*$//' | sed 's/^[^0-9]*//'`
echo "FILEDATE = $FILEDATE"
# ARCHIVE_GRAPH="${NAMED_GRAPH_BASE}`date -I`"
OUTOPT="-o ${OUT}"
FORMAT="NT"

if test "$2" == "debug"
then
    echo "Debug mode. No data will be uploaded."
    DEBUG=true
    FORMAT="TTL"
    OUTOPT=""
fi

java -jar ~/dev/sparql-anything-0.8.2.jar -v -q "${QUERY}" -f ${FORMAT} ${OUTOPT} -v loc="${FILE}" -v dt="${FILEDATE}"

if test "x$2" == "x"
then 
echo "Uploading to ${ARCHIVE_GRAPH}..."
curl -i -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<${ARCHIVE_GRAPH}>" "$SERVER"

echo "Clearing ${CURRENT_GRAPH}..."
curl -i -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${CURRENT_GRAPH}>" "$SERVER"

echo "Uploading to ${CURRENT_GRAPH}..."
curl -i -H "Content-Type: application/n-triples" --data-binary @"$UPLOAD" --url-query "context=<$CURRENT_GRAPH>" "$SERVER"
fi

echo "Done."