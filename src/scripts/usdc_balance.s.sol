// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IERC20Mintable } from "interfaces/IERC20Mintable.sol";

contract usdc_balance is ScriptHelper {
    function run() public virtual {
        _usdcBalance();
    }

    function _usdcBalance() public virtual returns (uint256) {
        IERC20Mintable usdc = IERC20Mintable(getAddress("USDC"));

        uint256 balance = usdc.balanceOf(msg.sender);

        console.log("USDC balance", balance);

        return balance;
    }
}
