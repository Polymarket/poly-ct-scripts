// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import { Vm } from 'forge-std/Vm.sol';

Vm constant vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

library String {
    function formatTokenAmount(uint256 _value, uint256 _decimals) internal pure returns (string memory) {
        uint256 one = 10 ** _decimals;

        // fractional
        string memory fractional = vm.toString(one + (_value % one));
        assembly {
            fractional := add(fractional, 1)
            mstore(fractional, _decimals)
        }

        // integral
        _value /= one;
        string memory integral = (_value == 0) ? '0' : vm.toString(_value);

        return string.concat(integral, '.', fractional);
    }
}
