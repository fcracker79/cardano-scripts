#!/bin/sh
ROOT="/opt/cardano/cardano/binaries/current"
ROOT_CONF="$ROOT/configuration/testnet/"

TOPOLOGY="$ROOT_CONF/testnet-topology.json"
CONFIG="$ROOT_CONF/testnet-config.json"
DATABASE="$ROOT/databases/testnet"
SOCKET="$ROOT/sockets/testnet.socket"

PORT=3001
HOST=127.0.0.1

ROOT_KEYS=$ROOT/keys/testnet
KES_SIGNING_KEY=$ROOT_KEYS/kes.skey
VRF_SIGNING_KEY=$ROOT_KEYS/vrf.skey
OPERATIONAL_CERTIFICATE_KEY=$ROOT_KEYS/op.cert

$ROOT/cardano-node run \
    --topology $TOPOLOGY \
    --config $CONFIG \
    --database-path $DATABASE \
    --socket-path $SOCKET \
    --port $PORT \
    --host-addr $HOST
    -shelley-kes-key $KES_SIGNING_KEY
    --shelley-vrf-key $VRF_SIGNING_KEY  \
    --shelley-operational-certificate $OPERATIONAL_CERTIFICATE_KEY \

