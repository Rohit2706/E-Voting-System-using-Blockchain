var voter = artifacts.require("./votersRegistration.sol");
module.exports = function(deployer) {
   deployer.deploy(voter);
};