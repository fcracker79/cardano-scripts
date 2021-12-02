#!/bin/bash

set -e

. commons.sh

$CARDANO address key-gen \
    --verification-key-file $USER1_VERIFICATION_KEY_FILE \
    --signing-key-file $USER1_SIGNING_KEY_FILE

$CARDANO address build \
    --payment-verification-key-file $USER1_VERIFICATION_KEY_FILE \
    --out-file $USER1_ADDRESS_FILE \
    --testnet-magic $TESTNET_MAGIC
USER1_PAYMENT_ADDRESS=`cat $USER1_ADDRESS_FILE`

$CARDANO address key-gen \
    --verification-key-file $USER2_VERIFICATION_KEY_FILE \
    --signing-key-file $USER2_SIGNING_KEY_FILE

$CARDANO address build \
    --payment-verification-key-file $USER2_VERIFICATION_KEY_FILE \
    --out-file $USER2_ADDRESS_FILE \
    --testnet-magic $TESTNET_MAGIC
USER2_PAYMENT_ADDRESS=`cat $USER2_ADDRESS_FILE`

$CARDANO address key-gen \
    --verification-key-file $USER3_VERIFICATION_KEY_FILE \
    --signing-key-file $USER3_SIGNING_KEY_FILE

$CARDANO address build \
    --payment-verification-key-file $USER3_VERIFICATION_KEY_FILE \
    --out-file $USER3_ADDRESS_FILE \
    --testnet-magic $TESTNET_MAGIC
USER3_PAYMENT_ADDRESS=`cat $USER3_ADDRESS_FILE`

echo User 1 address: $USER1_PAYMENT_ADDRESS
echo User 2 address: $USER2_PAYMENT_ADDRESS
echo User 3 address: $USER3_PAYMENT_ADDRESS
