// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IERC20 } from "interfaces/IERC20.sol";
import { IERC20Mintable } from "interfaces/IERC20Mintable.sol";

contract mint_usdc is ScriptHelper {
    function run() public virtual {
        vm.startBroadcast();
        _mint_usdc();
    }

    function _mint_usdc() public virtual {
        IERC20Mintable usdc = IERC20Mintable(getAddress("USDC"));

        uint256 usdcMintAmount = vm.envUint(usdcMintAmountKey);

        usdc.mint(msg.sender, usdcMintAmount);

        console.log("Minted", usdcMintAmount, "USDC");
    }
}
