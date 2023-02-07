// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from 'dev/ScriptHelper.sol';
import { IERC20Mintable } from 'interfaces/IERC20Mintable.sol';
import { IConditionalTokens } from 'interfaces/IConditionalTokens.sol';
import { CTHelpers } from 'libraries/CTHelpers.sol';
import { String } from 'libraries/String.sol';

contract balances is ScriptHelper {
    using String for uint256;

    function run() public virtual {
        walletAddress();
        gasTokenBalance();
        usdcBalance();
        tokenBalance();
    }

    function walletAddress() public {
        console.log('---');
        console.log('Wallet Address: ', msg.sender);
    }

    function gasTokenBalance() public {
        console.log('---');
        console.log('Gas Token Balance:', msg.sender.balance.formatTokenAmount(18));
    }

    function usdcBalance() public {
        console.log('---');
        IERC20Mintable usdc = IERC20Mintable(getAddress('USDC'));
        uint256 balance = usdc.balanceOf(msg.sender);
        console.log('USDC balance', balance.formatTokenAmount(6));
    }

    function tokenBalance() public {
        console.log('---');
        // get token balances in a binary market given a condition id
        IConditionalTokens ct = IConditionalTokens(getAddress('ConditionalTokens'));
        address usdc = getAddress('USDC');

        bytes32 conditionId = vm.envBytes32(conditionIdKey);
        console.log('Condition ID: ', vm.toString(conditionId));

        uint256 index = 0;

        while (index < 2) {
            string memory token = index == 0 ? 'TokenA' : 'TokenB';
            console.log(string.concat(token, ':'));
            uint256 indexSet = 1 << index;
            uint256 positionId =
                CTHelpers.getPositionId(usdc, CTHelpers.getCollectionId(parentCollectionId, conditionId, indexSet));

            console.log('    Outcome Index: ', index);
            console.log('    Position ID: ', positionId);
            console.log(
                string.concat('    ', token, ' Balance: ', ct.balanceOf(msg.sender, positionId).formatTokenAmount(6))
            );

            ++index;
        }
    }
}
