// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface Deployed{
    function store(uint256 num) external;
    function retrieve() external view returns (uint256);
}

contract Existing{
    Deployed dc;

    function call(address _addr) public{
        dc= Deployed(_addr);
    }

    function getA() public view returns (uint result){
        return dc.retrieve();
    }

    function setA(uint _val) public returns(uint result){
        dc.store(_val);
        return _val;
    }
}