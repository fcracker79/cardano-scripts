#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
COLD_VERIFICATION_KEY_FILE=$ROOT_KEYS/cold.vkey
COLD_SIGNING_KEY_FILE=$ROOT_KEYS/cold.skey
OPERATIONAL_CERTIFICATE_ISSUE_COUNTER_FILE=$ROOT_KEYS/cold.counter

$ROOT/cardano-cli node key-gen \
        --cold-verification-key-file $COLD_VERIFICATION_KEY_FILE \
        --cold-signing-key-file $COLD_SIGNING_KEY_FILE \
        --operational-certificate-issue-counter-file $OPERATIONAL_CERTIFICATE_ISSUE_COUNTER_FILE
