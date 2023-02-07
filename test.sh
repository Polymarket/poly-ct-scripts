#!/bin/bash

source .env

forge test --rpc-url "$ETH_RPC_URL" -vvv
