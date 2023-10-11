// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTINGBALENCE = 10 ether;

    function setUp() external {
        //fundme=new FundMe(0xD8Ea779b8FFC1096CA422D40588C4c0641709890);
        DeployFundMe df = new DeployFundMe();
        fundme = df.run();
        vm.deal(USER, STARTINGBALENCE);
    }

    function testDemo() public {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testOwerIsMsgSender() public {
        // assertEq(fundme.i_owner(),address(this));
        assertEq(fundme.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        // uint256 cat = 1;
        fundme.fund();
    }

    function testFundUpdateDataStructure() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        //uint256 amountFunded = fundme.getAddressToAmountFunded(msg.sender);
        // uint256 amountFunded = fundme.getAddressToAmountFunded(address(this));
        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
    function testAddsFunderToArrayOfFunders()public{
        vm.prank(USER);
        fundme.fund{value:STARTINGBALENCE}();
        address funder=fundme.getFunder(0);
        assertEq(funder,USER);
    }
    function testOnlyOwnerWithdraw()public{
        vm.prank(USER);
        fundme.fund{value:STARTINGBALENCE}();
        vm.prank(USER);
        vm.expectRevert();
        fundme.withdraw();
    }
}
