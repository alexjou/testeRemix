// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CofrinhoSeguro is ReentrancyGuard {
    mapping(address => uint256) public saldos;

    function depositar() external payable { // Qualquer um pode depositar
        require(msg.value > 0, "Valor deve ser maior que zero");
        saldos[msg.sender] += msg.value;
    }

    function sacar() external nonReentrant { // proteção contra reetrancia
        uint256 valor = saldos[msg.sender];
        // Check-Effect-Interaction pattern
        require(valor > 0, "Sem saldo para sacar"); //CHECK: verifica o valor
        saldos[msg.sender] = 0; // EFFECT: altera antes da transferência
        bool sucesso = payable(msg.sender).send(valor); // INTERACTION: interaje 
        require(sucesso, "Falha no envio");
    }

    function saldoAtual() external view returns (uint256) { //Apenas para visualização
        return saldos[msg.sender];
    }
}