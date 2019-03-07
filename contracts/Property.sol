pragma solidity ^0.5.0;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

contract Property is ERC721Token {
    address invitedGuest;

    constructor(string _name, string _symbol) public ERC721Token(_name, _symbol) {
        //leave empty for now, we've passed through the args above (i.e. super)
    }

    modifier onlyOwner(uint256 _tokenId) {
        require(tokenOwner[_tokenId] == msg.sender);
        _;
    }

    modifier onlyGuest {
        require(msg.sender == invitedGuest); //condition must be true
        _; //return to function and continue
    }

    function inviteGuest(address _guest) external onlyOwner returns(address) {
        invitedGuest = _guest;
        return invitedGuest;
    }

    function reserveRoom() external payable onlyGuest returns (bool) {
        if (msg.value < 1) {
            revert();
        }
    }

}