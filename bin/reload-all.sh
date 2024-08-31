#! /bin/bash

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements

# Clear current graphs
for NAMEBASE in "securities","activities","trades"; do
    NAMED_GRAPH_BASE="https://triples.beesondouglas.com/moneygraph__${NAMEBASE}__"
    echo "Clearing ${NAMED_GRAPH_BASE}..."
    curl -i -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NAMED_GRAPH_BASE}>" "$SERVER"
done

# Ontologies
sh bin/ontologies.sh

# Securities and Valuations
for f in `ls -U ../QTData/InvestmentSummary*.csv`; do 
    sh bin/securities.sh "$f"; 
    sh bin/valuation.sh "$f"
done

# Activities
for f in `ls -U ../QTData/Activities*.csv`; do 
    sh bin/activities.sh "$f"; 
done

# Trades
for f in `ls -U ../QTData/EconfirmationDetail*.csv`; do 
    sh bin/trades.sh "$f"; 
done

# Fix Trades
sh bin/fix-trades.sh

