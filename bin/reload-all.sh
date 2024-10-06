#! /bin/bash

PROJBASE=/Users/doug/dev/moneygraph
SERVER=http://127.0.0.1:7200/repositories/Investments/statements

# Clear current graphs
for NAMEBASE in "securities","balances","valuation","activities","trades"; do
    NAMED_GRAPH_BASE="https://triples.beesondouglas.com/moneygraph__${NAMEBASE}__"
    for SUFFIX in "","archive","extra"; do
        NG="${NAMED_GRAPH_BASE}${SUFFIX}"
        echo "Clearing ${NG}..."
        curl -fsSL -H "Content-Type: application/sparql-update" --data-binary "CLEAR GRAPH <${NG}>" "$SERVER"
    done
done

# Ontologies
sh bin/ontologies.sh

# Securities,Valuations
for f in `ls -U ../QTData/InvestmentSummary*.csv`; do 
    sh bin/securities.sh "$f" ;
    sh bin/valuation.sh "$f"
done

# Balances
for f in `ls -U ../QTData/Balances*.csv`; do 
    sh bin/balances.sh "$f" ;
done

# Activities
for f in `ls -U ../QTData/Activities*.csv`; do 
    sh bin/activities.sh "$f" ; 
done

# Trades
for f in `ls -U ../QTData/EconfirmationDetail*.csv`; do 
    sh bin/trades.sh "$f"; 
done

# Integrate Trade data into bond portfolio
sh bin/fix-missing-bond-data.sh

