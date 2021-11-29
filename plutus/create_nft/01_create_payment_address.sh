#!/bin/bash

. commons.sh

$CARDANO address key-gen \
    --verification-key-file $PAYMENT_VERIFICATION_KEY \
    --signing-key-file $PAYMENT_SIGNING_KEY

$CARDANO address build \
    --payment-verification-key-file $PAYMENT_VERIFICATION_KEY \
    --out-file $PAYMENT_ADDRESS_FILE \
    --testnet-magic $TESTNET_MAGIC

PAYMENT_ADDRESS=`cat $PAYMENT_ADDRESS_FILE`
echo Payment address: $PAYMENT_ADDRESS
