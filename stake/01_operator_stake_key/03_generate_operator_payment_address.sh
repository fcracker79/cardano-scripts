#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_PAYMENT_VERIFICATION_KEY=$ROOT_KEYS/op_pay.vkey
OPERATOR_PAYMENT_ADDRESS=$ROOT_KEYS/op_pay.addr

$ROOT/cardano-cli address build \
    --payment-verification-key-file $OPERATOR_PAYMENT_VERIFICATION_KEY \
    --testnet-magic 1097911063 > $OPERATOR_PAYMENT_ADDRESS
