#!/bin/bash

set -e

. commons.sh

function ensure_balance() {
    TOTAL_BALANCE=0
    PAYMENT_ADDRESS=$1    
    echo "Please charge address $PAYMENT_ADDRESS with at least 10 ADA"
    while [ $TOTAL_BALANCE -lt 10000000 ]; do
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
}
USER1_PAYMENT_ADDRESS=`cat $USER1_ADDRESS_FILE`
USER2_PAYMENT_ADDRESS=`cat $USER2_ADDRESS_FILE`
USER3_PAYMENT_ADDRESS=`cat $USER3_ADDRESS_FILE`


ensure_balance $USER1_PAYMENT_ADDRESS
ensure_balance $USER2_PAYMENT_ADDRESS
ensure_balance $USER3_PAYMENT_ADDRESS

