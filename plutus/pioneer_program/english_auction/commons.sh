#!/bin/sh

set -e

ROOT="/opt/cardano/cardano/binaries/current"
export CARDANO_NODE_SOCKET_PATH=$ROOT/sockets/testnet.socket
CARDANO=$ROOT/cardano-cli
TESTNET_MAGIC=1097911063
POLICY_ID_FILE=../../create_nft/data/MIRKOCOIN/policy_id
POLICY_ID=`cat $POLICY_ID_FILE`
TMP_BALANCE=data/balance
TOKEN_NAME=MIRKOCOIN

mkdir -p data/user1
mkdir -p data/user2
mkdir -p data/user3

USER1_VERIFICATION_KEY_FILE=data/user1/payment.vkey
USER1_SIGNING_KEY_FILE=data/user1/payment.skey
USER1_ADDRESS_FILE=data/user1/payment.addr
USER2_VERIFICATION_KEY_FILE=data/user2/payment.vkey
USER2_SIGNING_KEY_FILE=data/user2/payment.skey
USER2_ADDRESS_FILE=data/user2/payment.addr
USER3_VERIFICATION_KEY_FILE=data/user3/payment.vkey
USER3_SIGNING_KEY_FILE=data/user3/payment.skey
USER3_ADDRESS_FILE=data/user3/payment.addr
