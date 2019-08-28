pragma solidity ^0.5.10;

// we can use secondary ethereum addresses for anonymity and jwt for voting one time;
contract CandidateData{
    
    address payable admin;
    uint public registered_cand_count;
    uint public verified_cand_count;
    uint public registeration_period;
    uint public voting_period;
    address[10] candidates_for_voting;
    // To store the data for new Candidate
    
    struct Candidate{
        address id;
        string name;
        string dob;
        bytes gender;
        uint age;
        string fathers_name;
        string house_address;
        string disability;
        string complaint;
        Stage status;
        uint votes;
    }
    
    // To know the stage
    enum Stage {NotRegistered, Registered, Verified}
    
    mapping(address=>Candidate) candidates;
    
    modifier onlyEC{
        require(admin == msg.sender);
        _;
    }
    
    modifier onlyCandidate(address _id){
        require(_id == msg.sender);
        _;
    }
    
    modifier onlyRegistrationTime{
         require(now <= registeration_period, 'Registeration period is over');
         _;
    }
    
    modifier onlyVotingTime{
        require(now >= registeration_period, 'Voting period hasn\'t begun');
        require(now <= voting_period, 'Voting period is over');
         _;
    }
    
    //constructor
    constructor() public{
        registeration_period = now + 150 days;
        voting_period = registeration_period + 2 days;
        registered_cand_count = 0;
        verified_cand_count = 0;
        admin = msg.sender;
    }    
    
    function addCandidate(address _id, string memory _name, string memory _dob , string memory _gender, uint _age, string memory _fathers_name, string memory _house_address, string memory _disability) public onlyRegistrationTime{
        
        require(candidates[_id].status == Stage.NotRegistered, 'Candidate already registered.');
        
        //sample input: 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c, "Rohit", "27-06-1999",'M',20,"Manoj Kumar Jain", 'Delhi', 'None'
        candidates[_id].id = _id;
        candidates[_id].name = _name;
        candidates[_id].dob = _dob;
        candidates[_id].status = Stage.Registered;

        candidates[_id].gender = bytes(_gender);
        candidates[_id].age = _age;
        candidates[_id].fathers_name = _fathers_name;
        candidates[_id].house_address = _house_address;
        candidates[_id].disability = _disability;
        candidates[_id].votes = 0;
        registered_cand_count++;
        
        //Candidate goes for authentication
    }
    
    function viewCandidate(address _id) public view returns(address, string memory, string memory, Stage/*, bytes memory, uint, string memory, string memory, string memor, uinty*/){
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        return(candidates[_id].id,candidates[_id].name,candidates[_id].dob,candidates[_id].status/*, candidates[_id].gender, candidates[_id].age, candidates[_id].fathers_name, candidates[_id].house_address, candidates[_id].disability, candidates[_id].votes*/);
    }
    
    function authCandidate(address _id) public onlyEC onlyRegistrationTime{
        require(candidates[_id].status == Stage.Registered, 'Candidate does not exist or already authenticated');
        candidates[_id].status = Stage.Verified;
        verified_cand_count++;
        candidates_for_voting[verified_cand_count] = _id;
    }
    
    // setter functions
    
    function setName(address _id, string memory _name) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].name = _name;
        candidates[_id].status = Stage.Registered;

    }

    function setDOB(address _id, string memory _dob) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].dob = _dob;
        candidates[_id].status = Stage.Registered;
    }
    
    function setGender(address _id, string memory _gender) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].gender = bytes(_gender);
        candidates[_id].status = Stage.Registered;
    }
    
    function setAge(address _id, uint _age) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].age = _age;
        candidates[_id].status = Stage.Registered;
    }
    
    function setFather(address _id, string memory _fathers_name) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].fathers_name = _fathers_name;
        candidates[_id].status = Stage.Registered;
    }
    
    function setHouse(address _id, string memory _house_address) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].house_address = _house_address;
        candidates[_id].status = Stage.Registered;
    }
    
    function setDisability(address _id, string memory _disability) public onlyCandidate(_id) onlyRegistrationTime{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        candidates[_id].disability = _disability;
        candidates[_id].status = Stage.Registered;
    }
    function deleteCandidate(address _id) onlyEC public{
        delete candidates[_id];
    }
    function deleteContract() public onlyEC{
        selfdestruct(admin);
    }
    function addcomplaint(address _id, string memory _complaint) public onlyEC{
        candidates[_id].complaint = _complaint;
    }
    
    function vote(address _id) public{
        require(candidates[_id].status != Stage.NotRegistered, 'Candidate not registered.');
        (candidates[_id].votes)++;
    }
    
    function know_winner() public view returns(string memory,uint){
        uint max=0;
        address winner;
        for(uint i=1;i<=verified_cand_count;i++){
            address _id = candidates_for_voting[i];
            if(candidates[_id].votes>max){
                winner = _id;
            }
        }
        return (candidates[winner].name, candidates[winner].votes);
    }
}
