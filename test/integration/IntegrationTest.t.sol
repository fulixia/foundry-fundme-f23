// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe} from "../../script/Interactions.s.sol";

contract IntegrationTest is Test{
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTINGBALENCE = 10 ether;

    function setUp() external {
        DeployFundMe df = new DeployFundMe();
        fundme = df.run();
        vm.deal(USER, STARTINGBALENCE);
    }

    /* function testUserCanFund() public {
        FundFundMe ffm = new FundFundMe();
        vm.prank(USER);
        vm.deal(USER, 1e18);
        ffm.fundFundMe(address(fundme));
        address funder = fundme.getFunder(0);
        assertEq(funder, USER);
    } */
}
