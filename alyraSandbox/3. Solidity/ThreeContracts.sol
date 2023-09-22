// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.18;

contract parent {

    uint256 internal sum;
    // fonction pour set la value de sum, variable interne
    function setValue(uint256 _value) external {
        sum = _value;
    }
}

// contrat enfant
contract child is parent {
    // fonction pour retourner la valeur de sum du contrat hérité
    function getValue() external view returns (uint256) {
        return sum;
    }
}

// contrat caller
contract caller {
    // nouvelle instance de contrat enfant
    child cc = new child();

    // fonction qui appelle la fonction set value et get value du contrat enfant de la nouvelle instance
    function testInheritance(uint256 _value) public returns (address) {
        cc.setValue(_value);
        return address(cc);
    }
}