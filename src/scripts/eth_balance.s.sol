// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Script, console, stdJson} from "forge-std/Script.sol";

contract get_balance is Script {
    function run() public virtual {
        console.log(msg.sender.balance);
    }
}
