// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from 'dev/ScriptHelper.sol';
import { IConditionalTokens } from 'interfaces/IConditionalTokens.sol';
import { IERC20 } from 'interfaces/IERC20.sol';
import { String } from 'libraries/String.sol';

contract merge is ScriptHelper {
    using String for uint256;

    function run() public virtual {
        vm.startBroadcast();
        _merge();
    }

    function _merge() internal virtual {
        IConditionalTokens ct = IConditionalTokens(getAddress('ConditionalTokens'));
        IERC20 usdc = IERC20(getAddress('USDC'));

        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        uint256 mergeAmount = vm.envUint(amountKey);

        vm.startBroadcast();
        ct.mergePositions(usdc, bytes32(0), conditionId, getPartition(), mergeAmount);

        console.log(
            'Merged',
            mergeAmount.formatTokenAmount(6),
            'complete sets in market with condition id',
            vm.toString(conditionId)
        );
    }
}
