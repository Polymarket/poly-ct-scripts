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

        address conditionalTokens = getAddress('ConditionalTokens');
        address usdc = getAddress('USDC');
        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        uint256 mergeAmount = vm.envUint(amountKey);

        _merge(usdc, conditionalTokens, conditionId, mergeAmount);

        console.log(
            'Merged',
            mergeAmount.formatTokenAmount(6),
            'complete sets in market with condition id',
            vm.toString(conditionId)
        );
    }

    function _merge(address _usdc, address _conditionalTokens, bytes32 _conditionId, uint256 _mergeAmount)
        public
        virtual
    {
        IConditionalTokens(_conditionalTokens).mergePositions(
            IERC20(_usdc), bytes32(0), _conditionId, getPartition(), _mergeAmount
        );
    }
}
