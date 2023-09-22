// Import du smart contract "SimpleStorage"
const SimpleStorage = artifacts.require("SimpleStorage");

module.exports = async (deployer) => {
    // Deployer le smart contract!
    await deployer.deploy(SimpleStorage,7, {value:100000000000});
    var instance = await SimpleStorage.deployed();
    console.log(await instance.get());
}