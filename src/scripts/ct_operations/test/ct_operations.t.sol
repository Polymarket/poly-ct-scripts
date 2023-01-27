// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { ScriptHelper, console } from "dev/ScriptHelper.sol";
import { IERC20Mintable } from "interfaces/IERC20Mintable.sol";

import { Test } from "forge-std/Test.sol";
import { merge } from "scripts/ct_operations/merge.s.sol";
import { split } from "scripts/ct_operations/split.s.sol";
import { mint_usdc } from "scripts/mint_usdc.s.sol";
import { usdc_balance } from "scripts/usdc_balance.s.sol";

contract Runner is merge, split, mint_usdc, usdc_balance {
    function run() public override(merge, split, mint_usdc, usdc_balance) { }
}

contract test_ct_operations is ScriptHelper, Test, Runner {
    function testCtOperations() public virtual {
        IERC20Mintable usdc = IERC20Mintable(getAddress("USDC"));

        address sender = makeAddr("CTO_TEST_ACCOUNT");
        vm.startPrank(sender);

        uint256 usdcMintAmount = 2_000_000_000;
        vm.setEnv(usdcMintAmountKey, vm.toString(usdcMintAmount));
        _mint_usdc();

        assertEq(address(this), sender);
        uint256 balance = usdc.balanceOf(sender);
        assertEq(balance, usdcMintAmount);

        // uint256 splitAmount = 2_000_000_000;
        // vm.setEnv(splitAmountKey, vm.toString(splitAmount));
        // _split();

        // uint256 mergeAmount = 2_000_000_000;
        // vm.setEnv(mergeAmountKey, vm.toString(mergeAmount));
        // _merge();
    }
}
