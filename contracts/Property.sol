pragma solidity ^0.5.0;

import "./HelloWorld.sol";

contract Property is HelloWorld {
    address invitedGuest;

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