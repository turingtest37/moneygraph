#! /bin/sh

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMED_GRAPH_BASE=https://triples.beesondouglas.com/questrade/__ontology

GIST_GRAPH="${NAMED_GRAPH_BASE}__gist"
QT_GRAPH="${NAMED_GRAPH_BASE}__qt"
# echo $NAMED_GRAPH
QT_ONTOLOGY="${PROJBASE}/ontologies/questrade.ttl"

echo "Clearing gist ontology NG..."
curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${GIST_GRAPH}>" "$SERVER"

echo "Uploading gist ontology files..."
for UPLOAD in ${PROJBASE}/ontologies/gist*; do
echo "Uploading ${UPLOAD}..."
    curl -i -v -H "Content-Type: text/turtle" --data-binary @"$UPLOAD" --url-query "context=<${GIST_GRAPH}>" "$SERVER"
done

echo "Clearing Questrade ontology NG..."
curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${QT_GRAPH}>" "$SERVER"

echo "Uploading Questrade ontology ${QT_ONTOLOGY}..."
curl -i -v -H "Content-Type: text/turtle" --data-binary @"${QT_ONTOLOGY}" --url-query "context=<$QT_GRAPH>" "$SERVER"

