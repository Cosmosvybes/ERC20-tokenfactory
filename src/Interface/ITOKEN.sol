// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;

interface IERC20 {
    function balanceOf(address address_) external view returns (uint256);
    function name() external view returns (string memory);
    function decimals() external view returns (uint8);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(
        address owner,
        address _spender,
        uint256 amount
    ) external returns (bool);
    function transfer(address _to, uint256 amount) external returns (bool);
    function transferFrom(
        address owner,
        address to,
        uint256 amount
    ) external returns (bool);
    function totalSupply() external view returns (uint256);
    function mint(address _to, uint256 _amount) external returns (bool);
    event Transfer(address indexed _from, address indexed to_, uint256 amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 amount_
    );
}
