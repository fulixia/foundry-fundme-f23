//SPD-Licence-Identifier :MIT
//Fund
//Withdraw
pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE=0.01 ether;
    function fundFundMe(address mostRecentlyDeployed)  public  {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value:SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s",SEND_VALUE);
    }
    function run() external {
        address mostRecentluDeployed=DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        fundFundMe(mostRecentluDeployed);
    }
}

contract WithdrawFundMe is Script {
/* function run() external returns(FundMe){
        HelperConfig hc=new HelperConfig();
        (address ehtPriceFeed)=hc.activeNetworkConfig();
        vm.startBroadcast();
       // FundMe fundme=new FundMe();
      //FundMe fundme= new FundMe(0x31f24fbd9C175bCb2C1e341D65187eD7De701574);
      FundMe fundme= new FundMe(ehtPriceFeed);
        vm.stopBroadcast();
        return fundme;
    } */
}
