// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract CheckVariables{
    function getSender() public view returns (address) {
        return msg.sender;
    }
    function getValue() public payable returns (uint256) {
        return msg.value;
    } 
    function getData() public pure returns (bytes memory) {
        return msg.data;
    }
    function getSig() public pure returns (bytes4) {
        return msg.sig;
    }
}