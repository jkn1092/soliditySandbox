// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AssemblyTwo {
    receive() external payable {}

    function getReceivedEth() public view returns (uint256) {
        uint256 receivedEth;
        assembly {
            receivedEth := callvalue()
        }
        return receivedEth;
    }

}