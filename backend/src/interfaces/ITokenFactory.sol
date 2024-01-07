// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {IOptionToken} from "./IOptionToken.sol";
import {IBackingToken} from "./IBackingToken.sol";

interface ITokenFactory {
    function deployOptionToken(
        string memory name,
        string memory symbol,
        address underlying,
        uint256 expireTimestamp,
        address coreContract
    ) external returns (IOptionToken);

    function deployBackingToken(
        string memory name,
        string memory symbol,
        address underlying,
        uint256 expireTimestamp,
        address coreContract,
        address backedAsset
    ) external returns (IBackingToken);
}
