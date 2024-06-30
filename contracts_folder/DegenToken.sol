// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract Degen_Token is ERC20, Ownable {
    mapping(string => uint256) public itemPrices;
    event ItemRedeemed(address indexed user, string itemName, uint256 amount);

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        // Initialize item prices inside the constructor
        itemPrices["sword"] = 100 * 10**decimals(); 
        itemPrices["shield"] = 150 * 10**decimals(); 
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeemTokens(string memory itemName) external {
        uint256 itemPrice = itemPrices[itemName];
        require(itemPrice > 0, "Item not available");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient balance to redeem item");
        _burn(msg.sender, itemPrice);
        emit ItemRedeemed(msg.sender, itemName, itemPrice);
    }

    function getBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transferTokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        approve(msg.sender,amount);
        _transfer(msg.sender, recipient, amount);
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) public {
        uint256 decreasedAllowance = allowance(account, msg.sender) - amount;
        _approve(account, msg.sender, decreasedAllowance);
        _burn(account, amount);
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        uint256 currentAllowance = allowance(msg.sender, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(msg.sender, spender, currentAllowance - subtractedValue);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, allowance(msg.sender, spender) + addedValue);
        return true;
    }

    function renounceOwnership() public override onlyOwner {
        Ownable.renounceOwnership();
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        Ownable.transferOwnership(newOwner);
    }

    function showStore() external pure {
        revert("showStore is not implemented");
    }
}
