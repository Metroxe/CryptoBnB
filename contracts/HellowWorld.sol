pragma solidity ^0.4.24;

contract HelloWorld {
    //track the owner
    address internal owner;

    event Hello(string _msg);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function hello(string _msg) external onlyOwner {
        emit Hello(_msg);
    }

    function transferOwnership(address _owner) external onlyOwner returns(address) {
        owner = _owner;
        return owner;
    }

}