#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
VERIFICATION_KEY_FILE=$ROOT_KEYS/kes.vkey
SIGNING_KEY_FILE=$ROOT_KEYS/kes.skey

$ROOT/cardano-cli node key-gen-KES \
	--verification-key-file $VERIFICATION_KEY_FILE \
       	--signing-key-file $SIGNING_KEY_FILE

