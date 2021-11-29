#!/bin/bash

set -e
. commons.sh

$CARDANO address key-gen \
    --verification-key-file $POLICY_VERIFICATION_KEY \
    --signing-key-file $POLICY_SIGNING_KEY

KEY_HASH=`$CARDANO address key-hash --payment-verification-key-file $POLICY_VERIFICATION_KEY`
sed -e "s/__KEYHASH__/$KEY_HASH/" policy.script.template > $POLICY_FILE
