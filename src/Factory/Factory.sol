// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;
import {CustomToken} from "../Custom/CustomToken.sol";
import {SafeMath} from "../Safemath/SafeMath.sol";
import {TokenPOS, ITokenPOS} from "../Custom/CustomShop.sol";

contract Factory {
    using SafeMath for uint256;
    uint256 public tokenCount;
    TokenPOS tokenPos;

    constructor() {}

    function createToken(
        string memory tokenName,
        string memory tokenSybmbol,
        uint8 decimals_
    ) public returns (CustomToken) {
        CustomToken token_ = new CustomToken(msg.sender);
        token_.initialize(tokenName, tokenSybmbol, decimals_);
        tokenCount = tokenCount.add(1);
        return token_;
    }

    function createTokenPos() public returns (TokenPOS) {
        tokenPos = new TokenPOS(msg.sender);
        return tokenPos;
    }
}
