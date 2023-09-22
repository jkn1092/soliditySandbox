// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract SimpleStorage {

    enum WorkflowStatus {
        NotSet,
        Set,
        Complete
    }

    event stored(uint _data);
    uint public storageData;
    WorkflowStatus public workFlowStatus;

    function store(uint n) payable public {
        require(n!=2,"j'aime pas ce nombre");
        storageData = n;

        emit stored(n);
    }

    function updateStatus(uint _workflowStatus) public{
        workFlowStatus = WorkflowStatus(_workflowStatus);
    }

    function retrieve() public view returns (uint){
        return storageData;
    }
}