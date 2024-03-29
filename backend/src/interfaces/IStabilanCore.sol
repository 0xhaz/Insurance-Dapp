// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "./IBackingToken.sol";
import "./IOptionToken.sol";

interface IStabilanCore {
    error CannotExecute();
    error NotEnoughETHSent(uint256 msgValue, uint256 optionsPrice);
    error NotEnoughBacking(uint256 inEpochId, uint256 insuringAssetValue, uint256 totalAvailableCollateralUSD);

    struct AssetEpochData {
        uint256 strikePrice; // in USD 8 decimals
        uint256 collateralAmount; // in backing tokens
        uint256 reservedAmount; // in insurance tokens
        uint256 activeUntilTimestamp;
        uint256 totalPremium;
        IOptionToken optionToken;
        IBackingToken backingToken;
    }

    struct AssetConfig {
        address collateralAsset;
        uint256 collateralRatio;
        uint256 strikePricePercent;
        uint256 expectedApy;
    }

    function allStabilanTokens() external view returns (IOptionToken[] memory, IBackingToken[] memory);
}
