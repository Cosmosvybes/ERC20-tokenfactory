// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {Factory} from "../src/Factory/Factory.sol";
import {CustomToken} from "../src/Custom/CustomToken.sol";
import {TokenPOS} from "../src/Custom/CustomShop.sol";

contract FactoryTest is Test {
    Factory factory;
    CustomToken token_;
    CustomToken token_one;
    function setUp() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        factory = new Factory();
    }

    function testCreateTokenPOS() public returns (bool, bytes memory) {
        vm.prank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        token_ = factory.createToken("COSMOS TOKEN", "CMT", 4);
        vm.prank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
        token_one = factory.createToken("MAESTRO TOKEN", "MST", 8);
        vm.prank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        TokenPOS pos = factory.createTokenPos();
        vm.prank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
        TokenPOS pos_ = factory.createTokenPos();

        vm.prank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        pos.initializeToken(address(token_));

        vm.prank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
        pos_.initializeToken(address(token_one));

        vm.startPrank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        pos.startSales();
        token_.grantOwnerShip(address(pos));
        vm.stopPrank();

        vm.startPrank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
        pos_.startSales();
        token_one.grantOwnerShip(address(pos_));
        vm.stopPrank();

        vm.deal(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 1 ether);
        vm.prank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        (bool success, bytes memory data) = address(pos).call{
            value: 0.00012 ether
        }("");
        (bool success_one, bytes memory data_) = address(pos_).call{
            value: 0.00422 ether
        }("");

        return (success_one, data_);
    }
}
