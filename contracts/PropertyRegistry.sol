pragma solidity ^0.5.0;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Basic.sol";
import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";

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
    ERC20 propertyToken;

    //set up the property contract as minimum interface to prove ownership ERC721Basic
    constructor(address _property) public {
        property = ERC721Basic(_property);
        propertyToken = ERC20(_propertyToken);
    }

    modifier onlyOwner(uint256 _tokenId) {
        require(property.ownerOf(_tokenId) == msg.sender);
        _;
    }

    function registerProperty(uint256 _tokenId, uint256 _price) external onlyOwner(_tokenId) {
        stayData[_tokenId] = Data(_price, 0, address(0), address(0), address(0), 0, 0);
    }

    function request(uint256 _tokenId, uint256 _checkIn, uint256 _checkOut) external {
        require(stayData[_tokenId].requested == address(0));

        stayData[_tokenId].requested = msg.sender;
        stayData[_tokenId].checkIn = _checkIn;
        stayData[_tokenId].checkOut = _checkOut;
    }

    function approveRequest(uint256 _tokenId) external onlyOwner(_tokenId) {
        stayData[_tokenId].approved = stayData[_tokenId].requested;
    }

    function checkIn(uint256 _tokenId) external {
        require(stayData[_tokenId].approved == msg.sender);
        require(now > stayData[_tokenId].checkIn);
        //REQUIRED: transfer tokens to propertyRegistry upon successful check in
        //the message sender should have approved thr propertyRegistry to transfer
        //at least stayData[_tokenId].price tokens
        //address(this) == this contract address
        require(propertyToken.transferFrom(msg.sender, address(this), stayData[_tokenId].price));
        //move approved guest to occupant
        stayData[_tokenId].occupant = stayData[_tokenId].approved;
    }

    function checkOut(uint256 _tokenId) external {
        require(stayData[_tokenId].occupant == msg.sender);
        require(now < stayData[_tokenId].checkOut);
        //REQUIRED: transfer tokens to Alice upon successful check out
        require(propertyToken.transfer(property.ownerOf(_tokenId), stayData[_tokenId].price));
        //clear the request to let another guest request
        stayData[_tokenId].requested = address(0);
        stayData[_tokenId].stays++;
    }
}