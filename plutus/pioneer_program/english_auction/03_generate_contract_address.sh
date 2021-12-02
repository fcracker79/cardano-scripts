#!/bin/bash

set -e

. commons.sh

$CARDANO address build \
    --payment-script-file $PLUTUS_CONTRACT_FILE \
    --testnet-magic $TESTNET_MAGIC \
    --out-file $PLUTUS_CONTRACT_ADDRESS_FILE

echo Plutus contract address is `cat $PLUTUS_CONTRACT_ADDRESS_FILE`
