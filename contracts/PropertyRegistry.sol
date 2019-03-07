pragma solidity ^0.5.0;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Basic.sol";

contract PropertyRegistry {

    mapping(uint256 => Data) public stayData;

    struct Data {
        uint256 price;
        uint256 stays;
        address occupant;
        address requested;
        address approved;
        uint256 checkIn;
        uint256 checkOut;
    }

    // initialize the property registry variable
    ERC721Basic property;
    //set up the property contract as minimum interface to prove ownership ERC721Basic
    constructor(address _property) public {
        property = ERC721Basic(_property);
    }

    modifier onlyOwner(uint256 _tokenId) {
        require(property.ownerOf(_tokenId) == msg.sender);
        _;
    }

    function registerProperty(uint256 _tokenId, uint256 _price) external onlyOwner(_tokenId) {
        stayData[_tokenId] = Data(_price, 0, address(0));
    }
}