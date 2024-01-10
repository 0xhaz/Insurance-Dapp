// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/PriceFeedAggregator.sol";
import "../src/TokenFactory.sol";
import "../src/StabilanCore.sol";
import "../src/libraries/Constants.sol";
import "../src/mock/MockERC20.sol";
import "../src/mock/MockChronicleOracle.sol";
import "../src/Insrd.sol";
import "../src/InsurancePlugin.sol";
import "../src/DataProvider.sol";

contract Deploy is Script {
    function getChainId() public view returns (uint256) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return chainId;
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deployer Address: %s", deployerAddress);
        console.log("Deployer Balance: %s", address(deployerAddress).balance);
        console.log("BlockNumber: %s", block.number);
        console.log("ChainId: %s", getChainId());

        console.log("Deploying...");

        vm.startBroadcast(deployerPrivateKey);

        TokenFactory tokenFactory = new TokenFactory();
        console.log("TokenFactory: %s", address(tokenFactory));

        PriceFeedAggregator priceFeedAggregator = new PriceFeedAggregator(deployerAddress);

        console.log("PriceFeedAggregator: %s", address(priceFeedAggregator));

        StabilanCore stabilanCore = new StabilanCore(tokenFactory, priceFeedAggregator, deployerAddress);

        console.log("StabilanCore: %s", address(stabilanCore));

        DataProvider dataProvider = new DataProvider();
        console.log("DataProvider: %s", address(dataProvider));

        Insrd insrd = new Insrd();
        insrd.mint(deployerAddress, 10000 ether);
        console.log("Insrd: %s", address(insrd));

        MockChronicleOracle insrdPriceFeed = new MockChronicleOracle();
        insrdPriceFeed.setPrice(1 ether);
        console.log("InsrdPriceFeed: %s", address(insrdPriceFeed));

        InsurancePlugin insurancePlugin =
            new InsurancePlugin(address(stabilanCore), address(dataProvider), address(insrd));

        console.log("InsurancePlugin: %s", address(insurancePlugin));

        MockERC20 usdc = new MockERC20("USDC", "USDC");
        usdc.mint(deployerAddress, 100000 ether);
        console.log("USDC: %s", address(usdc));
    }
}
