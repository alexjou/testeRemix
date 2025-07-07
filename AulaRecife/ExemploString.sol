// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract ExemploString {
        string public str1 = "ola";

        function concatenar(string memory a, string memory b) public pure returns (string memory) {
            return string(abi.encodePacked(a," ", b));
        }

        function comparar(string memory a, string memory b) public pure returns (bool){
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }

        function contarString(string memory a) public pure returns (uint256) {
            return bytes(a).length;
        }

        function toBytes(string memory a) public pure returns (bytes memory) {
            return bytes(a);
        }

        function buscarCaractere(string memory a, uint256 index) public pure returns (string memory){
            bytes memory resultado = new bytes(1);
            resultado[0] = bytes(a)[index];
            return string(resultado);
        }
    }