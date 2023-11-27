//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22; 
contract Ballot {

    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
    }
    struct Proposal {
        uint voteCount;
    }
    enum Stage {Init,Reg, Vote, Done}
    Stage public stage = Stage.Init;
    
    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    
    uint startTime;   

    /// Create a new ballot with $(_numProposals) different proposals.
    constructor (uint8 _numProposals) {
        uint i;
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        Proposal memory zero_prop;
        zero_prop.voteCount = 0;

        for(i = 0; i < _numProposals; i++) 
        { 
            proposals.push(zero_prop); 
        }
        stage = Stage.Reg;
        startTime = block.timestamp;
    }
    

    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function register(address toVoter) public {
        if (stage != Stage.Reg) {return;}
        if (msg.sender != chairperson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
        if (block.timestamp > (startTime+ 10 seconds)) {stage = Stage.Vote; startTime = block.timestamp;}        
    }

    /// Give a single vote to proposal $(toProposal).
    function vote(uint8 toProposal) public  {
        if (stage != Stage.Vote) {return;}
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;   
        proposals[toProposal].voteCount += sender.weight;
        if (block.timestamp > (startTime+ 10 seconds)) {stage = Stage.Done;}        
        
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
       if(stage != Stage.Done) {return (255);}
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
       
    }
}
