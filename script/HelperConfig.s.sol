//SPDX-Licence-Identifier: MIT
//deploy mocks when we ar on a local anvil chain
//keep track of contract address accross diffrent chains
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggragator.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;
    struct NetworkConfig {
        address priceFeed; //ETH/USD feed address
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getEthMainConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x31f24fbd9C175bCb2C1e341D65187eD7De701574
        });
        return sepoliaConfig;
    }

    function getEthMainConfig() public pure returns (NetworkConfig memory) {}

    function getOrCreateAnvilEthConfig() public  returns (NetworkConfig memory) {
        //price feed address
        if (activeNetworkConfig.priceFeed != address(0))
            return activeNetworkConfig;
        //1.deploy the mocks
        //2.return the mock address
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }
}
