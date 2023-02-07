#!/bin/bash

source .env

while getopts "a:b" opt; do
    case "$opt" in
    a)
        AMOUNT=$(bc <<<"scale = 0;($OPTARG * 1000000)/1")
        export AMOUNT=$AMOUNT
        ;;
    b)
        BROADCAST=true
        ;;
    *)
        exit
        ;;
    esac
done
shift $((OPTIND - 1))

run() {
    forge script --rpc-url "$ETH_RPC_URL" \
        --private-key "$PRIVATE_KEY" \
        "$@"
}

if [ "$BROADCAST" = true ]; then
    run --broadcast "$1"
else
    run "$1"
fi
