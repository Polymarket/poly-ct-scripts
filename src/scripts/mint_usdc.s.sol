// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IERC20 } from "interfaces/IERC20.sol";
import { IERC20Mintable } from "interfaces/IERC20Mintable.sol";

contract mint_usdc is ScriptHelper {
    function run() public virtual {
        IERC20Mintable usdc = IERC20Mintable(getAddress("USDC"));

        vm.broadcast();
        usdc.mint(msg.sender, 1_000 * 10 ** 6);
    }
}
