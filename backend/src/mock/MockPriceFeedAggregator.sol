// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {IPriceFeedAggregator} from "../interfaces/IPriceFeedAggregator.sol";

contract MockPriceFeedAggregator is IPriceFeedAggregator {
    mapping(address => uint256) public prices;

    function setPrice(address asset, uint256 _price) external {
        prices[asset] = _price;
    }

    function getLatestPrice(address asset) external view override returns (uint256) {
        return prices[asset];
    }
}
