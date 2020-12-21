pragma solidity ^0.6.0;
import "./ERC20TD.sol";

contract DepositorContract {

    address public contractAddress = 0x58E9b79f804eBd4A3109068e1BE414D0BaAC18EC;

    mapping(address => uint256) claimedAddresses;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    event claimTokensFailed(address _address);
    event claimTokensSucceeded(address _address);

    function claimTokensFromTeacher() public {
        //contractAddress.call(bytes4(keccak256("claimTokens()")));
        contractAddress.call.value(1 ether).gas(10)(abi.encodeWithSignature("claimTokens()"));
        
        claimedAddresses[msg.sender] += 1000;
    }

    function approve(address spender, uint256 value)
    public
    returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(claimedAddresses[msg.sender] >= value);

        claimedAddresses[msg.sender] -= value;
        claimedAddresses[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
    public
    returns (bool success) {
        require(value <= claimedAddresses[from]);
        require(value <= allowance[from][msg.sender]);

        claimedAddresses[from] -= value;
        claimedAddresses[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}