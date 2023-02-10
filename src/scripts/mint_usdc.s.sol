// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from 'dev/ScriptHelper.sol';
import { IERC20 } from 'interfaces/IERC20.sol';
import { IERC20Mintable } from 'interfaces/IERC20Mintable.sol';
import { String } from 'libraries/String.sol';

contract mint_usdc is ScriptHelper {
    using String for uint256;

    function run() public virtual {
        vm.startBroadcast();

        address usdc = getAddress('USDC');
        uint256 usdcMintAmount = vm.envUint('AMOUNT');

        _mint_usdc(usdc, msg.sender, usdcMintAmount);

        console.log('Minted', usdcMintAmount.formatTokenAmount(6), 'USDC');
    }

    function _mint_usdc(address _usdc, address _to, uint256 _amount) public virtual {
        IERC20Mintable(_usdc).mint(_to, _amount);
    }
}
