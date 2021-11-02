#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
CARDANO=$ROOT/cli.sh
SIGNED_REGISTER_STAKE_TX=/tmp/tx.signed

$CARDANO transaction submit \
    --tx-file $SIGNED_REGISTER_STAKE_TX \
    --testnet-magic 1097911063 \
