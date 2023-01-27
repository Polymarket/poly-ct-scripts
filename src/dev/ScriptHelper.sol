// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { Script, console, stdJson } from "forge-std/Script.sol";

contract ScriptHelper is Script {
    string constant conditionIdKey = "CONDITION_ID";
    string constant splitAmountKey = "SPLIT_AMOUNT";
    string constant usdcMintAmountKey = "USDC_MINT_AMOUNT";
    bytes32 constant parentCollectionId = bytes32(0);

    using stdJson for string;

    function getAddress(string memory _key) internal returns (address) {
        string memory deploymentsDir = string.concat(vm.projectRoot(), "/deployments/");
        string memory chainDir = string.concat(vm.toString(block.chainid), "/");
        string memory fileContents = vm.readFile(string.concat(deploymentsDir, chainDir, "addresses.json"));
        address addr = fileContents.readAddress(_key);
        vm.label(addr, _key);

        return addr;
    }
}
