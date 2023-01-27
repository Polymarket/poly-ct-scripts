#!/bin/bash

source .env

run() {
    forge script --rpc-url "$ETH_RPC_URL" \
        --private-key "$PRIVATE_KEY" \
        "${@:1}"
}

run $1
