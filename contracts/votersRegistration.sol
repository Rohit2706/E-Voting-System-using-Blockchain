pragma solidity ^0.5.10;

// we can use secondary ethereum addresses for anonymity and jwt for voting one time;
contract VoterData{
    
    address payable admin;
    uint public registered_voter_count;
    uint public verified_voter_count;
    uint public registeration_period;
    uint public voting_period;
    // To store the data for new voter
    
    struct Voter{
        address id;
        string name;
        string dob;
        bytes gender;
        uint age;
        string fathers_name;
        string house_address;
        string disability;
        
        Stage status;
    }
    
    // To know the stage
    enum Stage {NotRegistered, Registered, Verified, Voted}
    
    mapping(address=>Voter) public voters;
    
    modifier onlyEC{
        require(admin == msg.sender);
        _;
    }
    
    modifier onlyVoter(address _id){
        require(_id == msg.sender);
        _;
    }
    
    modifier onlyRegistrationTime{
         require(now <= registeration_period, 'Registeration period is over');
         _;
    }
    
    function onlyVotingTime() public{
        require(now >= registeration_period, 'Voting period hasn\'t begun');
        require(now <= voting_period, 'Voting period is over');
    }
    
    //constructor
    constructor() public{
        registeration_period = now + 150 days;
        voting_period = registeration_period + 2 days;
        registered_voter_count = 0;
        verified_voter_count = 0;
        admin = msg.sender;
    }    
    
    function addVoter(address _id, string memory _name, string memory _dob , string memory _gender, uint _age, string memory _fathers_name, string memory _house_address, string memory _disability) public onlyRegistrationTime{
        
        require(voters[_id].status == Stage.NotRegistered, 'Voter already registered.');
        
        //sample input: 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c, "Rohit", "27-06-1999",'M',20,"Manoj Kumar Jain", 'Delhi', 'None'
        voters[_id].id = _id;
        voters[_id].name = _name;
        voters[_id].dob = _dob;
        voters[_id].status = Stage.Registered;

        voters[_id].gender = bytes(_gender);
        voters[_id].age = _age;
        voters[_id].fathers_name = _fathers_name;
        voters[_id].house_address = _house_address;
        voters[_id].disability = _disability;

        registered_voter_count++;
        
        //Voter goes for authentication
    }
    
    function viewVoter(address _id) public view returns(address, string memory, string memory, Stage/*, bytes memory, uint, string memory, string memory, string memory*/){
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        return(voters[_id].id,voters[_id].name,voters[_id].dob,voters[_id].status/*, voters[_id].gender, voters[_id].age, voters[_id].fathers_name, voters[_id].house_address, voters[_id].disability*/);
    }
    
    function authVoter(address _id) public onlyEC onlyRegistrationTime{
        require(voters[_id].status == Stage.Registered, 'Voter does not exist or already authenticated');
        voters[_id].status = Stage.Verified;
        verified_voter_count++;
    }
    
    // setter functions
    
    function setName(address _id, string memory _name) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].name = _name;
        voters[_id].status = Stage.Registered;

    }

    function setDOB(address _id, string memory _dob) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].dob = _dob;
        voters[_id].status = Stage.Registered;
    }
    
    function setGender(address _id, string memory _gender) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].gender = bytes(_gender);
        voters[_id].status = Stage.Registered;
    }
    
    function setAge(address _id, uint _age) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].age = _age;
        voters[_id].status = Stage.Registered;
    }
    
    function setFather(address _id, string memory _fathers_name) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].fathers_name = _fathers_name;
        voters[_id].status = Stage.Registered;
    }
    
    function setHouse(address _id, string memory _house_address) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].house_address = _house_address;
        voters[_id].status = Stage.Registered;
    }
    
    function setDisability(address _id, string memory _disability) public onlyVoter(_id) onlyRegistrationTime{
        require(voters[_id].status != Stage.NotRegistered, 'Voter not registered.');
        voters[_id].disability = _disability;
        voters[_id].status = Stage.Registered;
    }
    
    function deleteVoter(address _id) onlyEC public{
        delete voters[_id];
    }
    function deleteContract() public onlyEC{
        selfdestruct(admin);
    }
    
    function checkEligibility(address _id) view public returns(bool){
        return voters[_id].status == Stage.Verified;
        
    }
    
    function setStageVoted(address _id) public{
        voters[_id].status = Stage.Voted;
    }
}