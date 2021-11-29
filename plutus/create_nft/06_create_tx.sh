#!/bin/bash

set -e
. commons.sh

TX_IN=""
TX_IN_BALANCE=0

PAYMENT_ADDRESS=`cat $PAYMENT_ADDRESS_FILE`

$CARDANO query utxo \
        --address $PAYMENT_ADDRESS \
        --testnet-magic $TESTNET_MAGIC | tail -n +3 | sort -k3 -nr >$TMP_BALANCE
while read -r utxo; do
    IN_ADDR=`awk '{print $1 }' <<< "${utxo}"`
    IDX=`awk '{ print $2 }' <<< "${utxo}"`
    TX_IN_BALANCE=`awk '{ print $3 }' <<< "${utxo}"`
    if [ $TX_IN_BALANCE -ge 1000000 ]; then
        TX_IN="${IN_ADDR}#${IDX}"
        break
    fi
done < $TMP_BALANCE

echo UTXO $TX_IN
echo Balance $TX_IN_BALANCE

OUTPUT_NEEDED_FOR_NFT=1400000
TOKEN_AMOUNT=1
POLICY_ID=`cat $POLICY_ID_FILE`

$CARDANO transaction build \
    --testnet-magic $TESTNET_MAGIC \
    --alonzo-era \
    --tx-in $TX_IN \
    --tx-out $PAYMENT_ADDRESS+$OUTPUT_NEEDED_FOR_NFT+"$TOKEN_AMOUNT $POLICY_ID.$TOKEN_NAME" \
    --mint="$TOKEN_AMOUNT $POLICY_ID.$TOKEN_NAME" \
    --minting-script-file $POLICY_FILE \
    --metadata-json-file $METADATA_FILE \
    --witness-override 2 \
    --change-address $PAYMENT_ADDRESS \
    --out-file $MINTING_TX_FILE
    # --invalid-hereafter $slotnumber \
