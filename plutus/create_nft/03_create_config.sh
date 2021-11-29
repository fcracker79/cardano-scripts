#!/bin/bash

set -e
. commons.sh
$CARDANO query protocol-parameters \
    --testnet-magic $TESTNET_MAGIC \
    --out-file $PROTOCOL_FILE
