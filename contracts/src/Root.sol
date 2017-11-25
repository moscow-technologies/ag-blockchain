pragma solidity ^0.4.11;

import "./Owned.sol";

contract Root is Owned {
	uint public Count;
	mapping(uint => address) _addressMap;
	uint[] public _pollIds;
	address[] public _pollAddresses;
 
	function pushAddress(uint pollId, address contractAddress) onlyOwner {
		_addressMap[pollId] = contractAddress;
		_pollIds.push(pollId);
		_pollAddresses.push(contractAddress);
		Count++;
	}

	function getAllPollIds() constant returns(uint[]) {
		return _pollIds;
	}

	function getAllPollAddresses() constant returns(address[]) {
		return _pollAddresses;
	}

	function getAddress(uint pollId) constant returns (address contractAddress) {
		if (Count == 0) {
			return;
		}
		
		return _addressMap[pollId];
	}
}