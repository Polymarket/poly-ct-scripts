// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import { IERC20 } from './IERC20.sol';

/// @title IERC20Mintable
interface IERC20Mintable is IERC20 {
    function mint(address, uint256) external;
}
