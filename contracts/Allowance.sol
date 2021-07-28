// SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    mapping(address => uint) public myAllowance;
    
    event AllowanceAdded(address indexed _for, uint amount);
    
    function reduceAllowance(address _who, uint _amount) internal {
        myAllowance[_who] -= _amount;
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        myAllowance[_who] = _amount;
        emit AllowanceAdded(_who, _amount);
    }
}