// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

interface IPriceFeedAggregator {
    function getLatestPrice(address asset) external view returns (uint256);
}
