// SPDL-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import{FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
contract DeployFundMe is Script{
    function run() external returns(FundMe){
        HelperConfig hc=new HelperConfig();
        (address ehtPriceFeed)=hc.activeNetworkConfig();
        vm.startBroadcast();
       // FundMe fundme=new FundMe();
      //FundMe fundme= new FundMe(0x31f24fbd9C175bCb2C1e341D65187eD7De701574);
      FundMe fundme= new FundMe(ehtPriceFeed);
        vm.stopBroadcast();
        return fundme;
    }
}
