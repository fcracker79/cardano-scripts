#!/bin/sh

set -e

ROOT="/opt/cardano/cardano/binaries/current"
export CARDANO_NODE_SOCKET_PATH=$ROOT/sockets/testnet.socket
CARDANO=$ROOT/cardano-cli
POLICY_VERIFICATION_KEY=data/policy.vkey
POLICY_SIGNING_KEY=data/policy.skey
PAYMENT_VERIFICATION_KEY=data/payment.vkey
PAYMENT_SIGNING_KEY=data/payment.skey
TESTNET_MAGIC=1097911063
PAYMENT_ADDRESS_FILE=data/payment.addr
PROTOCOL_FILE=data/protocol.json
POLICY_FILE=data/policy.script
POLICY_ID_FILE=data/policy_id
TMP_BALANCE=data/balance
METADATA_FILE=data/metadata.json
TOKEN_NAME=MIRKOCOIN
MINTING_TX_FILE=data/matx.raw
SIGNED_MINTING_TX_FILE=data/matx.signed
