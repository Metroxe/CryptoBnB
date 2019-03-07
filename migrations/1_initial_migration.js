const Migrations = artifacts.require("Migrations");
const HelloWorld = artifacts.require("./HelloWorld.sol");
const Property = artifacts.require("./Property.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(HelloWorld);
  deployer.deploy(Property);
};
