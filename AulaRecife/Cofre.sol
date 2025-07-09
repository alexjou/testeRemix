// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Cofre {
    address public dono;
    constructor() {
        dono = msg.sender;
    }
    // Função que permite ao contrato receber Ether explicitamente
    function depositar() public payable {
        // o valor é automaticamente adicionado ao saldo do contrato 
    }

    // Função especial para receber Ether sem dados
    receive() external payable {
        // Nenhuma lógica necessária - o saldo é atualizado automaticamente
    }

   
    modifier apenasDono() {    
        require(msg.sender == dono, "Apenas o dono pode transferir");  
        _; // Aqui entra o corpo da função que usa o modifier
    }

    modifier temSaldo(uint256 valorTransferencia) {
        require(address(this).balance >= valorTransferencia, "Saldo insuficiente no contrato.");
        _;
    }

    function saldoDoContrato() public apenasDono view returns (uint256){
        return address(this).balance;
    }

    function transferirPara(address payable destinatario, uint256 valor) public apenasDono temSaldo(valor) {
        (bool success, ) = destinatario.call{value: valor}("");
    }
}