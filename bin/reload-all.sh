#! /bin/bash

PROJBASE=/Users/doug/dev/questrade
SERVER=http://127.0.0.1:7200/repositories/Investments/statements

# NAMEBASE=securities,activities,trades
for NAMEBASE in "securities","activities","trades"; do
    NAMED_GRAPH_BASE="https://triples.beesondouglas.com/questrade/__${NAMEBASE}__"
    echo "Clearing ${NAMED_GRAPH_BASE}..."
    curl -i -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NAMED_GRAPH_BASE}>" "$SERVER"
done


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

