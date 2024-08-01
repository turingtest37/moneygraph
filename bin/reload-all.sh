#! /bin/bash

# Securities
for f in `ls -U ../QTData/InvestmentSummary*`; do sh bin/securities.sh "$f"; done
