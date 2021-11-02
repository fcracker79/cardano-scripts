#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_STAKING_CERTIFICATE=$ROOT_KEYS/staking.cert
GENESIS_CONFIGURATION=$ROOT/configuration/testnet/testnet-shelley-genesis.json
PROTOCOL_PARAMS=$ROOT/configuration/testnet/testnet-config.json
OPERATOR_BASE_ADDRESS=$ROOT_KEYS/base.addr
OPERATOR_STAKING_CERTIFICATE=$ROOT_KEYS/staking.cert
OPERATOR_PAYMENT_SIGNING_KEY=$ROOT_KEYS/op_pay.skey
OPERATOR_STAKING_SIGNING_KEY=$ROOT_KEYS/staking.skey
CARDANO=$ROOT/cli.sh
TMP_TX=/tmp/tx.tmp
REGISTER_STAKE_TX=/tmp/tx.raw
SIGNED_REGISTER_STAKE_TX=/tmp/tx.signed
TMP_BALANCE=/tmp/balance.out
# From Configuration `keyDeposit`
STAKE_ADDRESS_DEPOSIT=2000000

$CARDANO query utxo \
    --address `cat $OPERATOR_BASE_ADDRESS` \
    --testnet-magic 1097911063 | tail -n +3 | sort -k3 -nr >$TMP_BALANCE
CURRENT_SLOT=`$CARDANO query tip --testnet-magic 1097911063 | jq -r '.slot'`

echo current slot $CURRENT_SLOT

TX_IN=""
TOTAL_BALANCE=0

while read -r utxo; do
    IN_ADDR=`awk '{print $1 }' <<< "${utxo}"`
    IDX=`awk '{ print $2 }' <<< "${utxo}"`
    UTXO_BALANCE=`awk '{ print $3 }' <<< "${utxo}"`
    TOTAL_BALANCE=$(($TOTAL_BALANCE+$UTXO_BALANCE))
    echo TxHash: ${IN_ADDR}#${IDX}
    echo ADA: ${UTXO_BALANCE}
    TX_IN="$TX_IN --tx-in ${IN_ADDR}#${IDX}"
done < $TMP_BALANCE

TXCNT=$(cat $TMP_BALANCE | wc -l)
echo Total ADA balance: ${TOTAL_BALANCE}
echo Number of UTXOs: ${TXCNT}

$CARDANO transaction build-raw \
    $TX_IN \
    --tx-out `cat $OPERATOR_BASE_ADDRESS`+0 \
    --invalid-hereafter $(( $CURRENT_SLOT + 10000)) \
    --fee 0 \
    --out-file $TMP_TX \
    --certificate $OPERATOR_STAKING_CERTIFICATE

FEE=$($CARDANO transaction calculate-min-fee \
    --tx-body-file $TMP_TX \
    --tx-in-count $TXCNT \
    --tx-out-count 1 \
    --witness-count 2 \
    --byron-witness-count 0 \
    --testnet-magic 1097911063 \
    --genesis $GENESIS_CONFIGURATION | awk '{ print $1 }')

echo fee: $FEE
TX_OUT=$(($TOTAL_BALANCE-$STAKE_ADDRESS_DEPOSIT-$FEE))
echo Change output: $TX_OUT

$CARDANO transaction build-raw \
    $TX_IN \
    --tx-out `cat $OPERATOR_BASE_ADDRESS`+$TX_OUT \
    --invalid-hereafter $(( ${CURRENT_SLOT} + 10000)) \
    --fee $FEE \
    --certificate-file $OPERATOR_STAKING_CERTIFICATE \
    --out-file $REGISTER_STAKE_TX

$CARDANO transaction sign \
    --tx-body-file $REGISTER_STAKE_TX \
    --signing-key-file $OPERATOR_PAYMENT_SIGNING_KEY \
    --signing-key-file $OPERATOR_STAKING_SIGNING_KEY \
    --testnet-magic 1097911063 \
    --out-file $SIGNED_REGISTER_STAKE_TX
