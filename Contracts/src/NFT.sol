// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract LISKNFT is ERC721URIStorage{
    uint256 public tokenCount;// count the number of token minted

    //struct to save user nfts

    struct UserNFT{
        uint256 tokenId;
        address userAddress;
        uint256  listPrice;
        string tokenURI;
        bool   isSold;

    }

    //mapping to save user nFTs

    mapping(uint => UserNFT)public usernfts;



    
    constructor()ERC721("Lisk","lsk"){}

    //function to mint nfts

    function mint(uint256 _listPrice,string memory _tokenURI)public{
        uint256 _tokencount = tokenCount;
        _safeMint(msg.sender,_tokencount);
        _setTokenURI(_tokencount, _tokenURI);

     usernfts[_tokencount] = UserNFT({tokenId:_tokencount,userAddress:msg.sender,listPrice:_listPrice,tokenURI:_tokenURI,isSold:false});
     tokenCount++;


    }
    //function to get all nfts in the market place

    function getAllNFTS()public view returns(UserNFT[] memory nfts){

        nfts = new UserNFT[](tokenCount);
        for(uint i = 0; i < tokenCount; i++) { //gas fee save ++i
            nfts[i] = usernfts[i];
        }
        return nfts;

    }

    function getAllUserNFTS(address _user)public  view returns(UserNFT[] memory nfts){
        uint256 count=0;
        for(uint256 i=0;i <tokenCount;i++){
            if(usernfts[i].userAddress == _user){
                count ++;
            }
        }
        nfts = new UserNFT[](count);
        uint256 index=0;
        for(uint256 i =0;i < tokenCount;i++){
            if(usernfts[i].userAddress == _user){
                nfts[index]= usernfts[i];
                index ++;
            }

        }
        return nfts;
    }
}