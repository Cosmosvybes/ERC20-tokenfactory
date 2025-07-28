// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;
import {IERC20} from "../Interface/ITOKEN.sol";
import {Ownable} from "../Custom/CustomToken.sol";
import {SafeMath} from "../Safemath/SafeMath.sol";
interface ITokenPOS {
    function startSales() external returns (bool);
    function initializeToken(address _token_address) external returns (bool);
}


contract TokenPOS is Ownable, ITokenPOS {
    address token;
    using SafeMath for uint256;
    uint256 tokenPrice = 100; //$1
    bool internal onSale;

    function getTokenAmount(uint256 _value) internal returns (uint256) {
        uint256 ether_value = _value;
        uint256 ether_usd_price = 4000_00000000;
        uint256 amountPaidInUsd = ether_value.mul(ether_usd_price).div(
            10 ** 18
        );
        uint256 tokenAmount = amountPaidInUsd.div(tokenPrice).div(
            10 ** (8 / IERC20(token).decimals())
        );
        return tokenAmount;
    }

    constructor(address _owner) Ownable(_owner) {
        onSale = false;
    }
    function startSales() public isOwner returns (bool) {
        return onSale = true;
    }

    function purchase(uint256 _amount) internal returns (bool) {
        require(onSale, "Token not on sale");
        IERC20(token).mint(msg.sender, _amount);
        return true;
    }
    function initializeToken(
        address _token_address
    ) public isOwner returns (bool) {
        token = _token_address;
        return true;
    }
    function getName() public view returns (string memory) {
        return IERC20(token).name();
    }

    receive() external payable {
        uint256 tokenAmount = getTokenAmount(msg.value);
        purchase(tokenAmount);
    }
}
