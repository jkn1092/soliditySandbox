const Send = artifacts.require("Send");

module.exports = (deployer) => {
    deployer.deploy(Send);
}