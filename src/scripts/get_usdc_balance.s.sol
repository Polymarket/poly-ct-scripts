// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IERC20Mintable } from "interfaces/IERC20Mintable.sol";

contract get_usdc_balance is ScriptHelper {
    function run() public virtual {
        IERC20Mintable usdc = IERC20Mintable(getAddress("USDC"));
        console.log(usdc.balanceOf(msg.sender));
    }
}
