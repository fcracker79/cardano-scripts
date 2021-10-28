#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_STAKING_VERIFICATION_KEY=$ROOT_KEYS/staking.vkey
OPERATOR_STAKING_CERTIFICATE=$ROOT_KEYS/staking.cert

$ROOT/cardano-cli stake-address registration-certificate \
    --staking-verification-key-file $OPERATOR_STAKING_VERIFICATION_KEY \
    --out-file $OPERATOR_STAKING_CERTIFICATE
