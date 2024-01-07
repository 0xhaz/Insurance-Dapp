// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {IStabilanCore} from "./IStabilanCore.sol";

interface IDataProvider {
    enum TokenType {
        OPTION,
        BACKING
    }

    struct UserToken {
        TokenType tokenType;
        address stabilanTokenAddress;
        address underlyingAssetAddress;
        address backedAsset;
        uint256 endEpoch;
        uint256 balance;
    }

    function getUserTokens(IStabilanCore core, address account) external view returns (UserToken[] memory);

    function getUserOptionTokens(IStabilanCore core, address account) external view returns (UserToken[] memory);

    function getUserBackingTokens(IStabilanCore core, address account) external view returns (UserToken[] memory);
}
