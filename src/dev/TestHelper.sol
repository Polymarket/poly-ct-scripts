// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import { Test, console } from 'forge-std/Test.sol';

abstract contract TestHelper is Test {
    function deployArtifact(string memory _name) internal returns (address) {
        return deployArtifact(_name, '');
    }

    function deployArtifact(string memory _name, bytes memory _constructorData) internal returns (address) {
        bytes memory bytecode =
            abi.encodePacked(vm.getCode(string.concat('artifacts/', _name, '.json')), _constructorData);
        address deployment;
        assembly {
            deployment := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        require(deployment != address(0), 'deployArtifact: failed');

        return deployment;
    }
}
