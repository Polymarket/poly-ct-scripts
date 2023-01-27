// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IConditionalTokens } from "interfaces/IConditionalTokens.sol";
import { IERC20 } from "interfaces/IERC20.sol";

contract split_collateral is ScriptHelper {
    function run() public virtual {
        IConditionalTokens ct = IConditionalTokens(getAddress("ConditionalTokens"));
        IERC20 usdc = IERC20(getAddress("USDC"));

        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        uint256 splitAmount = vm.envUint(splitAmountKey);

        uint256[] memory partition = new uint256[](2);
        partition[0] = 1;
        partition[1] = 2;

        vm.startBroadcast();
        usdc.approve(address(ct), splitAmount);
        ct.splitPosition(usdc, bytes32(0), conditionId, partition, splitAmount);

        console.log(
            "Split",
            vm.toString(splitAmount),
            "USDC into complete sets in market with condition id",
            vm.toString(conditionId)
        );
    }
}
