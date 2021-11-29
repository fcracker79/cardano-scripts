#!/bin/bash

set -e

. commons.sh

$CARDANO transaction policyid --script-file $POLICY_FILE > $POLICY_ID_FILE
sed -e "s/__POLICY_ID__/`cat $POLICY_ID_FILE`/" metadata.json.template |sed -e "s/__TOKEN_NAME__/$TOKEN_NAME/" > $METADATA_FILE
