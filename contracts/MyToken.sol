pragma solidity ^0.5.0;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract MyToken is StandardToken {


    string public constant name = "MyToken";
    string public constant symbol = "MYT";
    uint8 public constant decimals = 18;
    uint256 public leftToSell;

    constructor() public {
        // Max 50 tokens
        totalSupply_ = 50*10**uint256(decimals);
        // Set all the tokens to be owned by the contract
        balances[address(this)] = totalSupply_;
        // Keeps track of what is left to sell
        leftToSell = totalSupply_;
    }

    function() payable public {
        // Ensure we have enough to sell
        require(leftToSell > msg.value);
        // Reduce amount left to sell
        leftToSell = leftToSell.sub(msg.value);
        // Transfer the amount of tokens
        require(this.transfer(msg.sender, msg.value));
    }
}