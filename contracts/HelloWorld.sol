pragma solidity ^0.5.0;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract HelloWorld is Ownable {
    //track the owner
    address internal owner;

    constructor() public {
        owner = msg.sender; //deployer of contract
    }

    //log string
    event Hello(uint256 _msg);

    //protects functions from executing
    modifier onlyOwner {
        require(msg.sender == owner); //condition must be true
        _; //return to function and continue
    }

    //trivial hello function, only owner can call
    function hello(uint256 _msg) external onlyOwner {
        emit Hello(_msg); //note emit keyword
    }
}