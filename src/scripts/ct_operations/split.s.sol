// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IConditionalTokens } from "interfaces/IConditionalTokens.sol";
import { IERC20 } from "interfaces/IERC20.sol";

contract split is ScriptHelper {
    function run() public virtual {
        vm.startBroadcast();
        _split();
    }

    function _split() public virtual {
        IConditionalTokens ct = IConditionalTokens(getAddress("ConditionalTokens"));
        IERC20 usdc = IERC20(getAddress("USDC"));

        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        uint256 splitAmount = vm.envUint(splitAmountKey);

        usdc.approve(address(ct), splitAmount);
        ct.splitPosition(usdc, bytes32(0), conditionId, getPartition(), splitAmount);

        console.log("Split", vm.toString(splitAmount), "USDC in market with condition id", vm.toString(conditionId));
    }
}
