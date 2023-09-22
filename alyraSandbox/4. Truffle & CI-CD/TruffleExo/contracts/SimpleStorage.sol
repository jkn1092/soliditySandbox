// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract SimpleStorage {
    uint data;

    constructor (uint n) payable{
        data = n;
    }

    function set(uint x) public {
        data = x;
    }

    function get() public view returns (uint) {
        return data;
    }
}