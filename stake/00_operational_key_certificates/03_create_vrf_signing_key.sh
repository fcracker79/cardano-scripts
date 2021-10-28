#!/bin/sh

ROOT="/opt/cardano/cardano/binaries/current"
ROOT_KEYS=$ROOT/keys/testnet
VRF_VERIFICATION_KEY=$ROOT_KEYS/vrf.vkey
VRF_SIGNING_KEY=$ROOT_KEYS/vrf.skey
$ROOT/cardano-cli node key-gen-VRF \
    --verification-key-file $VRF_VERIFICATION_KEY \
    --signing-key-file $VRF_SIGNING_KEY
