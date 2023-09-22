pragma solidity 0.8.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SimpleStorage.sol";

contract TestSimpleStorage {

    function testItStoresAValue() public {
        SimpleStorage simpleStorage = SimpleStorage(DeployedAddresses.SimpleStorage());
        simpleStorage.store(89);
        uint expected = 89;
        Assert.equal(simpleStorage.retrieve(), expected, "It should store the value 89.");
    }
}