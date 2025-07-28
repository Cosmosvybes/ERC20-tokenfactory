// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;
import {IERC20} from "../Interface/ITOKEN.sol";
import {SafeMath} from "../Safemath/SafeMath.sol";

contract Ownable {
    address public owner;
    constructor(address _owner) {
        owner = _owner;
    }
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    function grantOwnerShip(address _owner) public isOwner returns (bool) {
        owner = _owner;
        return true;
    }
}

contract CustomToken is IERC20, Ownable {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 internal totalSupply_;
    using SafeMath for uint256;
    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowances;

    constructor(address _owner) Ownable(_owner) {}

    function _mint_(address _to, uint256 _amount) internal returns (bool) {
        balances[_to] = balances[_to].add(_amount);
        totalSupply_ = totalSupply_.add(_amount);
        emit Transfer(owner, _to, _amount);
        return true;
    }
    
    function mint(address _to, uint256 _amount) public isOwner returns (bool) {
        return _mint_(_to, _amount);
    }
    function balanceOf(address owner_) public view returns (uint256) {
        return balances[owner_];
    }
    function approve(
        address _owner,
        address spender_,
        uint256 _amount
    ) public returns (bool success) {
        allowances[_owner][spender_] = allowances[_owner][spender_].add(
            _amount
        );
        return true;
    }
    function allowance(
        address owner_,
        address _spender
    ) public view returns (uint256 balance) {
        return allowances[owner_][_spender];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(balances[msg.sender] >= _amount);
        require(_to != address(0));
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[msg.sender].add(_amount);
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public returns (bool) {
        require(allowances[_from][msg.sender] >= _amount);
        require(balances[_from] >= _amount);
        require(_to != address(0));
        allowances[_from][msg.sender] = allowances[_from][msg.sender].sub(
            _amount
        );
        balances[_from] = balances[_from].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        emit Transfer(_from, _to, _amount);
        return true;
    }
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }
    function initialize(
        string memory token_name,
        string memory tokenSymbol,
        uint8 decimals_
    ) public returns (bool success) {
        name = token_name;
        symbol = tokenSymbol;
        balances[owner] = balances[owner].add(totalSupply_);
        decimals = decimals_;
        emit Transfer(address(0), owner, totalSupply_);
        return true;
    }
}
