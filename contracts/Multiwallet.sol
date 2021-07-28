// SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./Allowance.sol";

contract MultiWallet is Allowance {
    event BalanceChanged(address indexed _from, uint amount);
    
    modifier ownerOrHasAllowance(uint _amount) {
        require(msg.sender == owner() || myAllowance[msg.sender] >= _amount, "You are not allowed to withdraw");
        _;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdraw(address payable _to, uint _amount) public payable ownerOrHasAllowance(_amount) {
        require(address(this).balance >= _amount, "Not enough balance");
        
        if(msg.sender != owner()) {
            reduceAllowance(_to, _amount);
        }
        
        _to.transfer(_amount);
        emit BalanceChanged(msg.sender, _amount);
    }
    
    function renounceOwnership() public onlyOwner {
        revert("Cannot renounce ownership")
    }
    
    receive() external payable {
        emit BalanceChanged(msg.sender, msg.value);
    }
}
