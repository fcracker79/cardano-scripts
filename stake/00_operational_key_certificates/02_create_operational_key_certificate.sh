#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet

COLD_KEY=$ROOT_KEYS/cold.skey
OPERATIONAL_CERTIFICATE_ISSUE_COUNTER=$ROOT_KEYS/cold.counter
KES_KEY=$ROOT_KEYS/kes.vkey
OPERATIONAL_CERTIFICATE_KEY=$ROOT_KEYS/op.cert

$ROOT/cardano-cli node issue-op-cert \
  --cold-signing-key-file $COLD_KEY \
  --operational-certificate-issue-counter $OPERATIONAL_CERTIFICATE_ISSUE_COUNTER \
  --hot-kes-verification-key-file $KES_KEY \
  --kes-period 0 \
  --out-file $OPERATIONAL_CERTIFICATE_KEY
