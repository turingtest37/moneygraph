#! /bin/sh

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMEBASE=fix-trades
QUERY=${PROJBASE}/queries/${NAMEBASE}.rq

if test "$1" == "debug"
then
    echo "Debug mode. No data will be uploaded."
    cat ${QUERY}
fi

if test "x$1" == "x"
then 
echo "UPDATING..."
curl -i -H "Content-Type: application/sparql-update" --data-binary @"${QUERY}" "$SERVER"
fi

echo "Done."