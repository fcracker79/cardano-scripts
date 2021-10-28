#!/bin/sh
ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_STAKING_VERIFICATION_KEY=$ROOT_KEYS/staking.vkey
OPERATOR_STAKING_SIGNING_KEY=$ROOT_KEYS/staking.skey

$ROOT/cardano-cli stake-address key-gen \
    --verification-key-file $OPERATOR_STAKING_VERIFICATION_KEY \
    --signing-key-file $OPERATOR_STAKING_SIGNING_KEY

