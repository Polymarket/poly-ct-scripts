// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { TestHelper, console } from 'dev/TestHelper.sol';
import { IERC20Mintable } from 'interfaces/IERC20Mintable.sol';
import { IConditionalTokens } from 'interfaces/IConditionalTokens.sol';
import { CTHelpers } from 'libraries/CTHelpers.sol';

import { merge } from 'scripts/ct_operations/merge.s.sol';
import { split } from 'scripts/ct_operations/split.s.sol';
import { mint_usdc } from 'scripts/mint_usdc.s.sol';
import { USDC } from 'dev/USDC.sol';

contract Runner is merge, split, mint_usdc {
    function run() public override(merge, split, mint_usdc) { }
}

contract test_ct_operations is TestHelper, Runner {
    address usdc;
    address conditionalTokens;

    bytes32 conditionId;
    uint256 positionIdA;
    uint256 positionIdB;

    function setUp() public {
        usdc = address(new USDC());
        conditionalTokens = deployArtifact('ConditionalTokens');

        IConditionalTokens(conditionalTokens).prepareCondition(address(0), 0, 2);
        conditionId = CTHelpers.getConditionId(address(0), 0, 2);
        positionIdA = CTHelpers.getPositionId(address(usdc), CTHelpers.getCollectionId(0, conditionId, 1));
        positionIdB = CTHelpers.getPositionId(address(usdc), CTHelpers.getCollectionId(0, conditionId, 2));
    }

    function testCtOperations() public {
        address sender = makeAddr('TEST_ACCOUNT');
        vm.startPrank(sender);

        uint256 usdcMintAmount = 2_000_000_000;
        _mint_usdc(usdc, sender, usdcMintAmount);

        uint256 balance = USDC(usdc).balanceOf(sender);
        assertEq(balance, usdcMintAmount);

        uint256 splitAmount = 2_000_000_000;
        _split(usdc, conditionalTokens, conditionId, splitAmount);

        assertEq(IConditionalTokens(conditionalTokens).balanceOf(sender, positionIdA), splitAmount);
        assertEq(IConditionalTokens(conditionalTokens).balanceOf(sender, positionIdB), splitAmount);
        assertEq(USDC(usdc).balanceOf(sender), 0);

        uint256 mergeAmount = 2_000_000_000;
        vm.setEnv(amountKey, vm.toString(mergeAmount));
        _merge(usdc, conditionalTokens, conditionId, mergeAmount);

        assertEq(IConditionalTokens(conditionalTokens).balanceOf(sender, positionIdA), 0);
        assertEq(IConditionalTokens(conditionalTokens).balanceOf(sender, positionIdB), 0);
        assertEq(USDC(usdc).balanceOf(sender), mergeAmount);
    }
}
