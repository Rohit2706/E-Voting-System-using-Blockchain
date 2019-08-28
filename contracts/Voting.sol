pragma solidity ^0.5.10;
import '.votersRegistration.sol';
import '.candidateRegistration.sol';
contract Voting{
   VoterData Voter;
   CandidateData Candidate;
    constructor(address _voterContract, address _candidateContract) public {
        Voter = VoterData(_voterContract);
        Candidate = CandidateData(_candidateContract);
    }
    
    function vote(address _id)  public {
        require(Voter.checkEligibility(msg.sender),'Voter not eligible');
        Voter.onlyVotingTime();
        Candidate.vote(_id);
        Voter.setStageVoted(msg.sender);
    }
    
    function viewResults() public view returns (string memory,uint){
        return Candidate.know_winner();
    }
}