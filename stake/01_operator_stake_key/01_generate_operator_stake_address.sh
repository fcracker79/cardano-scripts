#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
OPERATOR_STAKING_VERIFICATION_KEY=$ROOT_KEYS/staking.vkey
OPERATOR_STAKING_ADDRESS=$ROOT_KEYS/staking.addr

$ROOT/cardano-cli stake-address build \
    --staking-verification-key-file $OPERATOR_STAKING_VERIFICATION_KEY \
    --testnet-magic 1097911063 > $OPERATOR_STAKING_ADDRESS
