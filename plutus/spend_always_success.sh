#!/bin/bash

set -e

CARDANO_ROOT="/opt/cardano/cardano/binaries/current"
ALWAYS_SUCCESS_ADDRESS="addr_test1wpnlxv2xv9a9ucvnvzqakwepzl9ltx7jzgm53av2e9ncv4sysemm8"
DESTINATION_ADDRESS="addr_test1qzwfepasfunj5jz32j28aaf9yyqes407z5w5aprme5x5dj9gq7ta8wx0z9suyaqx69aaknfgehcyqz3f8znft2y4zxhsg86tx9"
CARDANO=$CARDANO_ROOT/cli.sh
TMP_BALANCE=/tmp/balance
PLUTUS_SCRIPT='/home/mirko/dev/haskell/cardano/plutus/plutus-starter/result.plutus'
TMP_TX=/tmp/tx
SIGNED_TMP_TX=/tmp/signed_tx
PROTOCOL_PARAMETERS_FILE=/tmp/protocol.json
TESTNET_MAGIC=1097911063
VERIFICATION_KEY_FILE=/tmp/a_key.vkey
SIGNING_KEY_FILE=/tmp/a_key.skey
DATUM_HASH="9e1199a988ba72ffd6e9c269cadb3b53b5f360ff99f112d9b2ee30c4d74ad88b"
DATUM=42

$CARDANO query utxo \
    --address $ALWAYS_SUCCESS_ADDRESS \
    --testnet-magic $TESTNET_MAGIC | tail -n +3 | sort -k3 -nr | grep $DATUM_HASH >$TMP_BALANCE

TX_IN=""
TOTAL_BALANCE=0

MAX_UTXO_BALANCE=-1
MIN_UTXO_BALANCE=-1
MAX_UTXO=""
MIN_UTXO=""
while read -r utxo; do
    IN_ADDR=`awk '{print $1 }' <<< "${utxo}"`
    IDX=`awk '{ print $2 }' <<< "${utxo}"`
    UTXO_BALANCE=`awk '{ print $3 }' <<< "${utxo}"`
    TOTAL_BALANCE=$(($TOTAL_BALANCE+$UTXO_BALANCE))
    # echo TxHash: ${IN_ADDR}#${IDX}
    # echo ADA: ${UTXO_BALANCE}
    CUR_TX_IN="${IN_ADDR}#${IDX}"
    TX_IN="$TX_IN --tx-in $CUR_TX_IN"
    if [ $MAX_UTXO_BALANCE -lt 0 ] || [ $MAX_UTXO_BALANCE -lt $UTXO_BALANCE ]; then
        MAX_UTXO_BALANCE=$UTXO_BALANCE
        MAX_UTXO=$CUR_TX_IN
    fi
    if [ $MIN_UTXO_BALANCE -lt 0 ] || [ $MIN_UTXO_BALANCE -gt $UTXO_BALANCE ]; then
        MIN_UTXO_BALANCE=$UTXO_BALANCE
        MIN_UTXO=$CUR_TX_IN
    fi

done < $TMP_BALANCE

TXCNT=$(cat $TMP_BALANCE | wc -l)
echo Total ADA balance: ${TOTAL_BALANCE}
echo Number of UTXOs: ${TXCNT}
echo Min UTXO: $MIN_UTXO
echo Max UTXO: $MAX_UTXO
echo Min UTXO balance: $MIN_UTXO_BALANCE
echo Max UTXO balance: $MAX_UTXO_BALANCE

$CARDANO query protocol-parameters --testnet-magic $TESTNET_MAGIC --out-file $PROTOCOL_PARAMETERS_FILE
CURRENT_SLOT=`$CARDANO query tip --testnet-magic $TESTNET_MAGIC | jq -r '.slot'`

$CARDANO transaction build-raw \
    --alonzo-era \
    --tx-out $DESTINATION_ADDRESS+0 \
    --invalid-hereafter $(( $CURRENT_SLOT + 10000)) \
    --fee 0 \
    --out-file $TMP_TX \
    --tx-in $MAX_UTXO \
    --tx-in-script-file $PLUTUS_SCRIPT \
    --tx-in-redeemer-value 42 \
    --tx-in-datum-value 42 \
    --tx-in-collateral $MIN_UTXO \
    --tx-in-execution-units '(500000,14400)' \
    --protocol-params-file $PROTOCOL_PARAMETERS_FILE

# We decided to spend just the max UTXO
TXCNT=1
FEE=$($CARDANO transaction calculate-min-fee \
    --tx-body-file $TMP_TX \
    --tx-in-count $TXCNT \
    --tx-out-count 1 \
    --witness-count 1 \
    --byron-witness-count 0 \
    --testnet-magic $TESTNET_MAGIC \
    --protocol-params-file $PROTOCOL_PARAMETERS_FILE | awk '{ print $1 }')

TX_OUT=$(($MAX_UTXO_BALANCE-$FEE))
echo Fee $FEE
echo Tx out $TX_OUT

$CARDANO transaction build-raw \
    --alonzo-era \
    --tx-out $DESTINATION_ADDRESS+$TX_OUT \
    --invalid-hereafter $(( $CURRENT_SLOT + 10000)) \
    --fee $FEE \
    --out-file $TMP_TX \
    --tx-in $MAX_UTXO \
    --tx-in-script-file $PLUTUS_SCRIPT \
    --tx-in-redeemer-value 42 \
    --tx-in-datum-value 42 \
    --tx-in-collateral $MIN_UTXO \
    --tx-in-execution-units '(500000,14400)' \
    --protocol-params-file $PROTOCOL_PARAMETERS_FILE

$CARDANO stake-address key-gen \
    --verification-key-file $VERIFICATION_KEY_FILE \
    --signing-key-file $SIGNING_KEY_FILE

$CARDANO transaction sign \
    --tx-body-file $TMP_TX \
    --testnet-magic $TESTNET_MAGIC \
    --signing-key-file $SIGNING_KEY_FILE \
    --out-file $SIGNED_TMP_TX

$CARDANO transaction submit --tx-file $SIGNED_TMP_TX --testnet-magic 1097911063
