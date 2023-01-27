// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { CTHelpers } from "libraries/CTHelpers.sol";
import { IConditionalTokens } from "interfaces/IConditionalTokens.sol";
import { IERC20 } from "interfaces/IERC20.sol";

contract get_ct_balance is ScriptHelper {
    function run() public virtual {
        // get token balances in a binary market given a condition id
        IConditionalTokens ct = IConditionalTokens(getAddress("ConditionalTokens"));
        address usdc = getAddress("USDC");

        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        console.log("condition id: ", vm.toString(conditionId));
        console.log("account address: ", msg.sender);

        uint256 index = 0;

        while (index < 2) {
            uint256 indexSet = 1 << index;
            uint256 positionId =
                CTHelpers.getPositionId(usdc, CTHelpers.getCollectionId(parentCollectionId, conditionId, indexSet));

            console.log("outcome index: ", index);
            console.log("position id: ", positionId);
            console.log("balance: ", ct.balanceOf(msg.sender, positionId));

            ++index;
        }
    }
}
