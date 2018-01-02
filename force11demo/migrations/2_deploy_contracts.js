var DocumentRegistry = artifacts.require("./DocumentRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(DocumentRegistry);
};
