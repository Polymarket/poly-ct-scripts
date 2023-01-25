// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IConditionalTokens } from "interfaces/IConditionalTokens.sol";
import { IERC20 } from "interfaces/IERC20.sol";

contract split_collateral is ScriptHelper {
    function run() public virtual {
        IConditionalTokens ct = IConditionalTokens(getAddress("ConditionalTokens"));
        bytes32 conditionId = hex"bd31dc8a20211944f6b70f31557f1001557b59905b7738480ca09bd4532f84af";
        IERC20 usdc = IERC20(getAddress("USDC"));

        uint256[] memory partition = new uint256[](2);
        partition[0] = 1;
        partition[1] = 2;

        uint256 amount = 500 * 10 ** 6;

        vm.startBroadcast();
        usdc.approve(address(ct), amount);
        ct.splitPosition(usdc, bytes32(0), conditionId, partition, amount);
    }
}
