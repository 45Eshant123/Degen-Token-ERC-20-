// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";
contract Degen_Token is ERC20, Ownable{
    mapping(address => mapping(address => uint256)) private _allowances;
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    function redeem_Tokens() external pure {
    revert("Redeeming tokens for items is not implemented");
    }
    function get_Balance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
    function burn_Tokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }
    function transfer_Tokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, recipient, amount);
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function burn(uint256 amount) public virtual {
        _burn(msg.sender, amount);
    }
    function burn_From(address account, uint256 amount) public virtual {
        uint256 decreased_Allowance = allowance(account, msg.sender) - amount;
        _approve(account, msg.sender, decreased_Allowance);
        _burn(account, amount);
    }
    function decrease_Allow(address spender, uint256 subtracted_Value) public virtual returns (bool) {
        uint256 currentAllowance = allowance(msg.sender, spender);
        require(currentAllowance >= subtracted_Value, "ERC20: decreased allowance below zero");
        _approve(msg.sender, spender, currentAllowance - subtracted_Value);
        return true;
    }
    function increase_Allow(address spender, uint256 added_Value) public virtual returns (bool) {
        _approve(msg.sender, spender, allowance(msg.sender, spender) + added_Value);
        return true;
    }
    function renounce_Owners() public virtual  onlyOwner {
        renounceOwnership();
    }
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, allowance(sender, msg.sender) - amount);
        return true;
    }
    function transfer_Owners(address new_Owner) public virtual onlyOwner {
        transferOwnership(new_Owner);
    }
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    function show_Storelter() external pure {
        revert("show-Storelter is not implemented");
    }
}
