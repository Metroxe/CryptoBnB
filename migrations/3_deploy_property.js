const Property = artifacts.require("./Property.sol");

module.exports = function(deployer) {
    deployer.deploy(Property, 'Property', 'PROP');
};