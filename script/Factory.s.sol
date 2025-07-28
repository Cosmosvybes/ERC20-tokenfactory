// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;
import {Script, console} from "forge-std/Script.sol";
import {Factory} from "../src/Factory/Factory.sol";
import {CustomToken} from "../src/Custom/CustomToken.sol";
contract FactoryScript is Script {
    Factory factory;
    function setUp() public {}
    function run() public {
        vm.startBroadcast();
        factory = new Factory();
        CustomToken token_ = factory.createToken("FLICKS TOKEN", "FLT", 4);
        console.log(address(token_));
        vm.stopBroadcast();
    }
}
