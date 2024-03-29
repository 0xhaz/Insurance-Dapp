// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "./interfaces/IBackingToken.sol";
import "./interfaces/IOptionToken.sol";
import "./OptionToken.sol";
import "./BackingToken.sol";
import "./interfaces/ITokenFactory.sol";

contract TokenFactory is ITokenFactory {
    function deployOptionToken(
        string memory name,
        string memory symbol,
        address underlying,
        uint256 expireTimestamp,
        address coreContract
    ) external returns (IOptionToken) {
        return IOptionToken(new OptionToken(name, symbol, IERC20(underlying), expireTimestamp, coreContract));
    }

    function deployBackingToken(
        string memory name,
        string memory symbol,
        address underlying,
        uint256 expireTimestamp,
        address coreContract,
        address backedAsset
    ) external returns (IBackingToken) {
        return IBackingToken(
            new BackingToken(name, symbol, IERC20(underlying), expireTimestamp, coreContract, backedAsset)
        );
    }
}
