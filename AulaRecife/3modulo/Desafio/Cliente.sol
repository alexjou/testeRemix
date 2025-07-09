// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./InterfaceICofre.sol"; // Poderia ser um arquivo em repositorio externo

contract Cliente {
    address public cofreEndereco; // 0x9E4E37b6c07ADc1BF79779f2d128f2AB10Cd7C59
    // Endereço do contratoCliente - 0x25BB6f57e1255c0A4cB29CBeD3dd32925f00664b
    event Interacao(string acao, address usuario, uint256 valor);
    constructor(address _cofre) { // O endereço de deploy do contrato COFRE
        cofreEndereco = _cofre;
    }

    function enviarDeposito() external payable { ///CEI
        require(msg.value > 0, "Precisa enviar algum Ether");
        ICofre(cofreEndereco).depositar{value: msg.value}();
        emit Interacao("deposito", msg.sender, msg.value);
    }

    function verMeuSaldo() external view returns (uint256) {
        return ICofre(cofreEndereco).consultarSaldo(address(this));
    }

    function requisitarSaque(uint256 valor) external {
        ICofre(cofreEndereco).sacar(valor);
        emit Interacao("saque", msg.sender, valor);
    }
}
