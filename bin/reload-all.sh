#! /bin/bash

# Securities and Valuations
for f in `ls -U ../QTData/InvestmentSummary*.csv`; do 
    sh bin/securities.sh "$f"; 
    sh bin/valuation.sh "$f"
done
