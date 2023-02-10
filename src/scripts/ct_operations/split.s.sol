// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from 'dev/ScriptHelper.sol';
import { IConditionalTokens } from 'interfaces/IConditionalTokens.sol';
import { IERC20 } from 'interfaces/IERC20.sol';
import { String } from 'libraries/String.sol';

contract split is ScriptHelper {
    using String for uint256;

    function run() public virtual {
        vm.startBroadcast();

        address conditionalTokens = getAddress('ConditionalTokens');
        address usdc = getAddress('USDC');
        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        uint256 splitAmount = vm.envUint(amountKey);

        _split(usdc, conditionalTokens, conditionId, splitAmount);

        console.log(
            'Split', splitAmount.formatTokenAmount(6), 'USDC in market with condition id', vm.toString(conditionId)
        );
    }

    function _split(address _collateral, address _conditionalTokens, bytes32 _conditionId, uint256 _splitAmount)
        public
        virtual
    {
        IERC20(_collateral).approve(address(_conditionalTokens), _splitAmount);
        IConditionalTokens(_conditionalTokens).splitPosition(
            IERC20(_collateral), bytes32(0), _conditionId, getPartition(), _splitAmount
        );
    }
}
