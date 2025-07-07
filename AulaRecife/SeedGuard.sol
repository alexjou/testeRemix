// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract SeedGuard {
    struct Usuario {
        address endereco;
        string mensagem;
    }
    mapping(address => Usuario) private usuarios;
    constructor() {}
    function guardarMensagem(string memory mens) public returns (bool sucesso)
    {
        Usuario memory u = Usuario(msg.sender, mens);
        usuarios[msg.sender] = u;
        return true;
    }
    function lerMensagem() public view returns (string memory) {
        return usuarios[msg.sender].mensagem;
    }
}