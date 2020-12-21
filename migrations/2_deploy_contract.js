var ERC20 = artifacts.require("../contracts/ERC20TD.sol");

module.exports = function(deployer) {
deployer.deploy(ERC20);
};
