// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { Script, console, stdJson } from 'forge-std/Script.sol';

abstract contract ScriptHelper is Script {
    string constant conditionIdKey = 'CONDITION_ID';
    string constant amountKey = 'AMOUNT';
    bytes32 constant parentCollectionId = bytes32(0);

    using stdJson for string;

    function getAddress(string memory _key) internal returns (address) {
        string memory deploymentsDir = string.concat(vm.projectRoot(), '/deployments/');
        string memory chainDir = string.concat(vm.toString(block.chainid), '/');
        string memory fileContents = vm.readFile(string.concat(deploymentsDir, chainDir, 'addresses.json'));
        address addr = fileContents.readAddress(_key);
        vm.label(addr, _key);

        return addr;
    }

    function getPartition() internal pure returns (uint256[] memory) {
        return getPartition(2);
    }

    function getPartition(uint256 _outcomeCount) internal pure returns (uint256[] memory) {
        uint256[] memory partition = new uint256[](_outcomeCount);

        uint256 i;
        uint256 indexSet = 1;
        for (; i < _outcomeCount;) {
            partition[i] = indexSet;

            indexSet <<= 1;
            ++i;
        }

        return partition;
    }
}
