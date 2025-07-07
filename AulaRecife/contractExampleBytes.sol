// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ExampleBytes {
    bytes private mensagem;
    bool private comparacao;

    string public nome = " Jose";
    string public str1=" Ana";
    string public str2=" Maria";

    // comprimento
        byte b = bytes(str)[i];
        uint tamanho = bytes(str).lenght

    function setBytesValue(string memory b) public {
        // abi.encodePacked concatena strings
        mensagem = abi.encodePacked(b, nome, str1, str2);
        // keccak256 compara dados
        comparacao = keccak256(bytes(str1)) == keccak256(bytes(str2));
        

    }
    function getBytesValue() public view returns (string memory)
    {
        return string(mensagem);
    }
}