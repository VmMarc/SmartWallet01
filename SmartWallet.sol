// SPDX-License-Identifier: MIT
// 1000000000000000

pragma solidity ^0.8.0;

contract SmartWallet {
    mapping(address => uint256) private _balances;
    mapping(address => bool) _owners;

    constructor() {
        _owners[msg.sender] = true;
    }
  
    function addOwner(address account) public {
        require(_owners[msg.sender] == true, "SmartWallet: Only an owner can add owner");
        _owners[account] = true;
    }
  
    function isOwner(address account) public view returns (bool) {
        return _owners[account];
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
    }
    
    
    // Exercice 1:
    function withdrawAmount(uint256 amount) public {
        require(_balances[msg.sender] >= (amount), "SmartWallet: You do not have enough credits");
        
        _balances[msg.sender] -= (amount);
        payable(msg.sender).transfer(amount);
    }
    
    
    // Exercice 2:
    function transfer(address account_, uint256 amount_) public {
        require(_balances[msg.sender] >= (amount_), "SmartWallet: You do not have enough credits");

        _balances[msg.sender] -= (amount_);
        _balances[account_] += (amount_);
    }
    
    function withdraw() public {
        require(_balances[msg.sender] > 0, "SmartWallet: can not withdraw 0 ether");
        uint256 amount = _balances[msg.sender];
        _balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
    
    function total() public view returns (uint256) {
        return address(this).balance;
    }
}