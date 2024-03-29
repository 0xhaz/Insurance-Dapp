// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "./interfaces/IStabilanCore.sol";
import "./interfaces/IOptionToken.sol";
import "./interfaces/IDataProvider.sol";
import "./interfaces/IBackingToken.sol";

contract DataProvider is IDataProvider {
    function getUserTokens(IStabilanCore core, address account) external view returns (UserToken[] memory) {
        UserToken[] memory userTokensTemp = new UserToken[](100);
        uint256 userTokenLen = 0;

        IOptionToken[] memory optionTokens;
        IBackingToken[] memory backingTokens;
        (optionTokens, backingTokens) = core.allStabilanTokens();

        for (uint256 i; i < optionTokens.length; i++) {
            uint256 balance = optionTokens[i].balanceOf(account);
            if (balance > 0) {
                userTokensTemp[userTokenLen++] = UserToken({
                    tokenType: TokenType.OPTION,
                    stabilanTokenAddress: address(optionTokens[i]),
                    underlyingAssetAddress: address(optionTokens[i].underlying()),
                    backedAsset: address(0),
                    endEpoch: optionTokens[i].endEpoch(),
                    balance: balance
                });
            }
        }

        for (uint256 i; i < backingTokens.length; i++) {
            uint256 balance = backingTokens[i].balanceOf(account);
            if (balance > 0) {
                userTokensTemp[userTokenLen++] = UserToken({
                    tokenType: TokenType.BACKING,
                    stabilanTokenAddress: address(backingTokens[i]),
                    underlyingAssetAddress: address(backingTokens[i].underlying()),
                    backedAsset: backingTokens[i].backedAsset(),
                    endEpoch: backingTokens[i].endEpoch(),
                    balance: balance
                });
            }
        }

        UserToken[] memory userTokens = new UserToken[](userTokenLen);
        for (uint256 i; i < userTokenLen; i++) {
            userTokens[i] = userTokensTemp[i];
        }

        return userTokens;
    }

    function getUserOptionTokens(IStabilanCore core, address account)
        external
        view
        override
        returns (UserToken[] memory)
    {
        UserToken[] memory userTokensTemp = new UserToken[](100);
        uint256 userTokenLen = 0;

        IOptionToken[] memory optionTokens;
        (optionTokens,) = core.allStabilanTokens();

        for (uint256 i; i < optionTokens.length; i++) {
            uint256 balance = optionTokens[i].balanceOf(account);
            if (balance > 0) {
                userTokensTemp[userTokenLen++] = UserToken({
                    tokenType: TokenType.OPTION,
                    stabilanTokenAddress: address(optionTokens[i]),
                    underlyingAssetAddress: address(optionTokens[i].underlying()),
                    backedAsset: address(0),
                    endEpoch: optionTokens[i].endEpoch(),
                    balance: balance
                });
            }
        }

        UserToken[] memory userTokens = new UserToken[](userTokenLen);
        for (uint256 i; i < userTokenLen; i++) {
            userTokens[i] = userTokensTemp[i];
        }

        return userTokens;
    }

    function getUserBackingTokens(IStabilanCore core, address account)
        external
        view
        override
        returns (UserToken[] memory)
    {
        UserToken[] memory userTokensTemp = new UserToken[](100);
        uint256 userTokenLen = 0;

        IBackingToken[] memory backingTokens;
        (, backingTokens) = core.allStabilanTokens();

        for (uint256 i; i < backingTokens.length; i++) {
            uint256 balance = backingTokens[i].balanceOf(account);
            if (balance > 0) {
                userTokensTemp[userTokenLen++] = UserToken({
                    tokenType: TokenType.BACKING,
                    stabilanTokenAddress: address(backingTokens[i]),
                    underlyingAssetAddress: address(backingTokens[i].underlying()),
                    backedAsset: backingTokens[i].backedAsset(),
                    endEpoch: backingTokens[i].endEpoch(),
                    balance: balance
                });
            }
        }

        UserToken[] memory userTokens = new UserToken[](userTokenLen);
        for (uint256 i; i < userTokenLen; i++) {
            userTokens[i] = userTokensTemp[i];
        }

        return userTokens;
    }
}
