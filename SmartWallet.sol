// SPDX-License-Identifier: MIT
// 1000000000000000

pragma solidity ^0.8.0;

contract SmartWallet {
    mapping(address => uint256) private _balances;
    mapping(address => bool) _owners;
    uint256 private _percentage;
    uint256 private _gain;

    constructor(uint256 percentage_) {
        require(
            percentage_ >= 0 && percentage_ <= 100,
            "Percentage must be between 0 and 100"
        );
        _owners[msg.sender] = true;
        _percentage = percentage_;
    }

    //Exercice 4
    function setPercentage(uint256 newPercentage) public {
        require(
            _owners[msg.sender] == true,
            "SmartWallet: Only an owner can change percentage"
        );
        require(
            newPercentage >= 0 && newPercentage <= 100,
            "Percentage must be between 0 and 100"
        );
        _percentage = newPercentage;
    }

    function addOwner(address account) public {
        require(
            _owners[msg.sender] == true,
            "SmartWallet: Only an owner can add owner"
        );
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
        require(
            _balances[msg.sender] >= (amount),
            "SmartWallet: You do not have enough credits"
        );
        _balances[msg.sender] -= (amount);
        payable(msg.sender).transfer(amount);
        // Todo pourcentage sur amount + incrémentation _gain
    }

    // Exercice 2:
    function transfer(address account_, uint256 amount_) public {
        require(
            _balances[msg.sender] >= (amount_),
            "SmartWallet: You do not have enough credits"
        );
        _balances[msg.sender] -= (amount_);
        _balances[account_] += (amount_);
    }

    function withdraw() public {
        require(
            _balances[msg.sender] > 0,
            "SmartWallet: can not withdraw 0 ether"
        );
        uint256 amount = _balances[msg.sender];
        _balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        // Todo pourcentage sur amount + incrémentation _gain
    }

    function total() public view returns (uint256) {
        return address(this).balance;
    }

    //Exercice 5
    function gain() public view returns (uint256) {
        return _gain;
    }

    function percentage() public view returns (uint256) {
        return _percentage;
    }
}
