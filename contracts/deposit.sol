// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";


contract DeploymentExample is Ownable(address(this)) {
    // rest of your code remains unchanged...

    mapping(address => uint256) public balances;
    uint256 public totalDeposited;

    event Deposited(address indexed who, uint256 amount);
    event Withdrawn(address indexed who, uint256 amount);

    // Функция для получения эфира
    receive() external payable {
        depositEther();
    }

    function depositEther() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value; // Используем встроенные операции
        totalDeposited += msg.value; // Используем встроенные операции
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount; // Используем встроенные операции
        totalDeposited -= _amount; // Используем встроенные операции
        payable(msg.sender).transfer(_amount);
        emit Withdrawn(msg.sender, _amount);
    }

    // function kill() public onlyOwner {
    //     selfdestruct(payable(owner()));
    // }
}