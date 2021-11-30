#!/bin/bash

set -e
. commons.sh

$CARDANO query utxo --address `cat $PAYMENT_ADDRESS_FILE` --testnet-magic $TESTNET_MAGIC
