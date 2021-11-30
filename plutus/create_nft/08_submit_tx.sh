#!/bin/bash

set -e
. commons.sh

$CARDANO transaction submit --testnet-magic $TESTNET_MAGIC --tx-file $SIGNED_MINTING_TX_FILE
