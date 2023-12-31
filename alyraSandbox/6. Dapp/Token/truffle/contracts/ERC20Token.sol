// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    constructor() ERC20("ALYRA", "ALY") {
        _mint(msg.sender, 1000 ether);
    }
}