// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract Degen_Token is ERC20, Ownable {
    mapping(string => uint256) public item_Prices;
    string[] public itemNames;
    event Item_Redeemed(address indexed user, string itemName, uint256 amount);

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        item_Prices["sword"] = 100 * 10**decimals();
        item_Prices["shield"] = 150 * 10**decimals();
        itemNames.push("sword");
        itemNames.push("shield");
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeem_Tokens(string memory item_Name) external {
        uint256 _itemPrice = item_Prices[item_Name];
        require(_itemPrice > 0, "Item not available");
        require(balanceOf(msg.sender) >= _itemPrice, "Insufficient balance to redeem item");
        _burn(msg.sender, _itemPrice);
        emit Item_Redeemed(msg.sender, item_Name, _itemPrice);
    }

    function getBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transferTokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        approve(msg.sender, amount);
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

    // in this function we are displaying all those available items which are in the store
    function showStore() external view returns (string memory) {
        string memory store = "Available items are:-\n";
        for (uint256 i = 0; i < itemNames.length; i++) {
            store = string(abi.encodePacked(store, itemNames[i], ": ", uint2str(item_Prices[itemNames[i]] / 10**decimals()), " DGN\n"));
        }
        return store;
    }

    // in this function with the help function we convert uint256 value into string
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}


    function showStore() external pure {
        revert("showStore is not implemented");
    }
}
