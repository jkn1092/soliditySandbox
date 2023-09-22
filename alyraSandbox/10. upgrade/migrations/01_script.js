// 01_deploy.js

const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const StorageV1= artifacts.require('StorageV1');

module.exports = async function (deployer) {

    const instance = await deployProxy(StorageV1, [3], { deployer, initializer: 'store' });

    console.log('Deployed', instance.address)
};


//0x65762b4389CD37CE1BC62954Da1d2693526BDB3C
//0x54c02560D411e0Becc12859d0837A36dA93E839C