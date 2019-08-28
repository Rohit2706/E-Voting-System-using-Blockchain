var cand = artifacts.require("./candidateRegistration.sol");
module.exports = function(deployer) {
   deployer.deploy(cand);
};