// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title Voting
 * @dev Implements voting process
 */
contract Voting is Ownable{

    event VoterRegistered(address voterAddress);
    event VoterUnregistered(address voterAddress);
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted (address voter, uint proposalId);

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }

    struct Proposal {
        string description;
        uint voteCount;
    }

    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }

    WorkflowStatus public votingStatus;
    mapping (address => Voter) private voters;
    Proposal[] public proposals;
    uint public winningProposalId;

    /**
     * @dev Check if the address is registered
     */
    modifier onlyRegistered(){
        require(voters[msg.sender].isRegistered, "Not Authorized");
        _;
    }

    /**
     * @dev Create a new voting with a 'Blank Vote' Proposal by default
     */
    constructor(){
        proposals.push(Proposal("Blank Vote", 0));
    }

    /**
     * @dev Register a voter
     * @param _address address of voter
     */
    function register(address _address) external onlyOwner {
        require(votingStatus == WorkflowStatus.RegisteringVoters, "Registration is not possible.");
        require(!voters[_address].isRegistered, "Registered already.");

        voters[_address].isRegistered = true;
        emit VoterRegistered(_address);
    }

    /**
     * @dev Unregister a voter
     * @param _address address of voter
     */
    function unregister(address _address) external onlyOwner {
        require(votingStatus == WorkflowStatus.RegisteringVoters, "Unregistration is not possible.");
        require(voters[_address].isRegistered, "Unregistered already.");

        voters[_address].isRegistered = false;
        emit VoterUnregistered(_address);
    }

    /**
     * @dev Check voter's vote
     * @param _address address of voter to check
     * @return votedProposalId voted proposal ID from voter
     */
    function checkVote(address _address) external view onlyRegistered returns(uint){
        require(voters[_address].isRegistered, "Not registered.");
        require(voters[_address].hasVoted, "Not voted.");

        return voters[_address].votedProposalId;
    }

    /**
    * @dev Update the workflow status to the next one
    */
    function nextWorkflowStatus() public onlyOwner {
        require(votingStatus != WorkflowStatus.VotesTallied, "Voting process has been completed. Winner has been picked.");
        require(votingStatus != WorkflowStatus.VotingSessionEnded, "Voting process has been completed. Votes need to be counted.");

        WorkflowStatus previousVotingStatus = votingStatus;
        votingStatus = WorkflowStatus(uint(votingStatus) + 1);
        emit WorkflowStatusChange(previousVotingStatus, votingStatus);
    }

    /**
     * @dev Add proposal
     * @param _description description of proposal
     */
    function addProposal(string memory _description) external onlyRegistered {
        require(votingStatus == WorkflowStatus.ProposalsRegistrationStarted, "Proposals Registration is not possible.");

        proposals.push(Proposal(_description, 0));
        emit ProposalRegistered(proposals.length - 1);
    }

    /**
     * @dev Add vote
     * @param _proposalId index of proposal to vote
     */
    function vote(uint _proposalId) external onlyRegistered {
        require(votingStatus == WorkflowStatus.VotingSessionStarted, "Voting is not possible.");
        require(!voters[msg.sender].hasVoted, "Voted already");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = _proposalId;
        proposals[_proposalId].voteCount++;
        emit Voted(msg.sender, _proposalId);
    }

    /**
    * @dev Counting votes
    */
    function countVote() external onlyOwner {
        require(votingStatus == WorkflowStatus.VotingSessionEnded, "Voting is not finish.");

        for(uint i=1; i < proposals.length; i++){
            if(proposals[i].voteCount > proposals[winningProposalId].voteCount){
                winningProposalId = i;
            }
        }

        votingStatus = WorkflowStatus.VotesTallied;
        emit WorkflowStatusChange( WorkflowStatus.VotingSessionEnded, votingStatus);
    }

    /**
    * @dev Get Winner of Proposals
    * @return winningProposalId index of winning proposal
    * @return description description of proposal
    */
    function getWinner() external view returns(uint, string memory) {
        require(votingStatus == WorkflowStatus.VotesTallied, "Winner has not been decided yet.");

        return (winningProposalId, proposals[winningProposalId].description);
    }
}