// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AcessoRestrito {  
    address public dono;  
    
    constructor() {       
        dono = msg.sender;      
    }
    
    modifier apenasDono() {    
        require(msg.sender == dono, "Apenas o dono pode executar");  
        _; // Aqui entra o corpo da função que usa o modifier
    }

    function encerrarContrato() public apenasDono {
        selfdestruct(payable(dono));
    }

    function sayHello() view public apenasDono returns (string memory v){
        return "Ola, Mundo!";
    }
}