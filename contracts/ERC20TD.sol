pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20TD is ERC20 {

    constructor() public ERC20("TD-ERC20", "TDE") {
    _mint(msg.sender, 1000000000000000000);
    }

    function claimTokens() public
    {
    _mint(msg.sender, 10000000000000000);
    }

}