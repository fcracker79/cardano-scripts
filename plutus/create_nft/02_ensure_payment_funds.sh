#!/bin/bash

set -e
. commons.sh

TMP_BALANCE=/tmp/balance
PAYMENT_ADDRESS=`cat $PAYMENT_ADDRESS_FILE`

TOTAL_BALANCE=0

echo "Please charge address $PAYMENT_ADDRESS with at least 5 ADA"
while [ $TOTAL_BALANCE -lt 5000000 ]; do
    TOTAL_BALANCE=0
    $CARDANO query utxo \
        --address $PAYMENT_ADDRESS \
        --testnet-magic $TESTNET_MAGIC | tail -n +3 | sort -k3 -nr >$TMP_BALANCE
    while read -r utxo; do
        IN_ADDR=`awk '{print $1 }' <<< "${utxo}"`
        IDX=`awk '{ print $2 }' <<< "${utxo}"`
        UTXO_BALANCE=`awk '{ print $3 }' <<< "${utxo}"`
        TOTAL_BALANCE=$(($TOTAL_BALANCE+$UTXO_BALANCE))
    done < $TMP_BALANCE
done
echo $TOTAL_BALANCE
