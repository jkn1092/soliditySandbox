// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint initialSupply) ERC20("Ugokin","UGK"){
        _mint(msg.sender, initialSupply);
    }
}