pragma solidity ^0.4.11;

contract Owned {
    address owner;
    event AccessDenied(address account);

    modifier onlyOwner() {
        if (msg.sender == owner) {
            _;
        }
        else {
            AccessDenied(msg.sender);
        }
    }

    function Owned() {
        owner = msg.sender;
    }

    function changeOwner(address _newOwner) onlyOwner {
        owner = _newOwner;
    }
}