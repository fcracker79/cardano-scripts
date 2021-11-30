#!/bin/bash

set -e
. commons.sh

$CARDANO transaction sign  \
    --signing-key-file $PAYMENT_SIGNING_KEY \
    --signing-key-file $POLICY_SIGNING_KEY  \
    --testnet-magic $TESTNET_MAGIC \
    --tx-body-file $MINTING_TX_FILE \
    --out-file $SIGNED_MINTING_TX_FILE
