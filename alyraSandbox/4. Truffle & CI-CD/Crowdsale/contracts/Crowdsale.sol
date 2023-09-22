// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "./ERC20Token.sol";

contract Crowdsale {
    uint public rate = 200; // le taux à utiliser
    ERC20Token public token; // L’instance ERC20Token à déployer

    constructor(uint initialSupply) {
        token = new ERC20Token(initialSupply); // crée une nouvelle instance du smart       contract ERC20Token ! L’instance ERC20Token déployée sera stockée dans la variable “token”
    }

    receive() external payable {
        require(msg.value >= 0.1 ether, "You can't send less than 0.1 ether");
        distribute(msg.value);
    }

    function distribute(uint amount) internal {
        uint tokensToSent = amount * rate;

        token.transfer(msg.sender, tokensToSent);
    }
}