// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VerificadorSimples {
    uint public contador;

    // Exemplo de uso do require
    function incrementar(uint valor) public {
        require(valor > 0, "Valor deve ser maior que zero");
        contador += valor;
    }

    // Exemplo de uso de revert
    function decrementar(uint valor) public {
        if (valor > contador) {
            revert("Valor excede o contador atual");
        }
        contador -= valor;
    }
    // Exemplo de uso do assert
    function verificadorInvariavel() public view returns (bool) {
        assert(contador >= 0); // sempre deve ser verdadeiro, não pode valor negativo
        return true;
    }
}