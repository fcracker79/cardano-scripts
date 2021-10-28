#!/bin/sh
ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_PAYMENT_VERIFICATION_KEY=$ROOT_KEYS/op_pay.vkey
OPERATOR_PAYMENT_SIGNING_KEY=$ROOT_KEYS/op_pay.skey

$ROOT/cardano-cli address key-gen \
    --verification-key-file $OPERATOR_PAYMENT_VERIFICATION_KEY \
    --signing-key-file $OPERATOR_PAYMENT_SIGNING_KEY

