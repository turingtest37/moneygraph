#! /bin/sh

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements
NAMED_GRAPH_BASE=https://w3id.org/moneygraph/ns/data/__ontology

GIST_GRAPH="${NAMED_GRAPH_BASE}__gist"
MG_GRAPH="${NAMED_GRAPH_BASE}__mg"
# echo $NAMED_GRAPH
MG_ONTOLOGY="${PROJBASE}/ontologies/moneygraph.ttl"
MG_ONTOLOGY_EXPORT="${PROJBASE}/out/moneygraph_export.ttl"

echo "Getting moneygraph ready for export..."
onto_tool export -f turtle -o "${MG_ONTOLOGY_EXPORT}" -b strict "${MG_ONTOLOGY}"

echo "Clearing gist ontology NG..."
curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${GIST_GRAPH}>" "$SERVER"

echo "Uploading gist ontology files..."
for UPLOAD in ${PROJBASE}/ontologies/gist*.ttl; do
echo "Uploading ${UPLOAD}..."
    curl -i -v -H "Content-Type: text/turtle" --data-binary @"$UPLOAD" --url-query "context=<${GIST_GRAPH}>" "$SERVER"
done

echo "Clearing Moneygraph ontology NG..."
curl -i -v -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${MG_GRAPH}>" "$SERVER"

echo "Uploading Moneygraph ontology ${MG_ONTOLOGY}..."
curl -i -v -H "Content-Type: text/turtle" --data-binary @"${MG_ONTOLOGY_EXPORT}" --url-query "context=<$MG_GRAPH>" "$SERVER"

