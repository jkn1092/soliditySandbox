// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

//import Open Zepplin contracts

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract NFTs is ERC721 {

    uint256 private _tokenIds;

    uint datetoreveal;

    mapping(address => bool) minted;

    constructor() ERC721("Animals Mix", "AMX") {}


    //use the mint function to create an NFT. Mint le plus simple possible ici

    function mint() public returns (uint256)  {
        require(_tokenIds <=50, "too much nft");
        require(minted[msg.sender]==false, "tu es gourmand");

        _tokenIds += 1;

        _mint(msg.sender, _tokenIds);
        minted[msg.sender]=true;

        return _tokenIds;

    }

    //in the function below include the CID of the JSON folder on IPFS

    function tokenURI(uint256 _tokenId) override public view returns(string memory) {

        if(block.timestamp<datetoreveal){
            return "https://gateway.pinata.cloud/ipfs/CIDDEMETADATA/hiden.json";
        }
        else{
            return string(
                abi.encodePacked("https://gateway.pinata.cloud/ipfs/bafybeid7jhwfpu4j3fe62tb7akz4mdyue7sm7w4fju2c4rpicpv44jy5my/",Strings.toString(_tokenId),".json")
            );
        }
    }

}