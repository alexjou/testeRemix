// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./InterfaceICofre.sol"; // Poderia ser um arquivo em repositorio externo

contract Cofre is ICofre {
    mapping(address => uint256) public creditos; // Saldos por endereço
    event Deposito(address indexed de, uint256 valor);
    event Saque(address indexed para, uint valor);

    function depositar() external payable {
        require(msg.value > 0, "Envie algum Ether");
        creditos[msg.sender] += msg.value;
        emit Deposito(msg.sender, msg.value);
    }

    function consultarSaldo(address usuario) external view returns (uint256) {
        return creditos[usuario];
    }

    function sacar(uint256 valor) external {
        require(creditos[msg.sender] >= valor, "Saldo insuficiente");
        creditos[msg.sender] -= valor;
        payable(msg.sender).transfer(valor);
        emit Saque(msg.sender, valor);
    }
}