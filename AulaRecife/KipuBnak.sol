// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KipuBank {
    address public owner;
    uint256 public bankCap;
    uint256 public totalDeposits;
    
    mapping(address => uint256) public userBalances;
    
    event Deposit(address indexed user, uint256 amount, uint256 balance);
    event Withdrawal(address indexed user, uint256 amount, uint256 balance);
    event FailedDeposit(address indexed user, uint256 amount, string reason);
    event FailedWithdrawal(address indexed user, uint256 amount, string reason);
    
    constructor(uint256 _bankCap) {
        owner = msg.sender;
        bankCap = _bankCap;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Apenas o dono pode executar esta acao");
        _;
    }
    
    function deposit() external payable {
        // Verificar se o valor é maior que zero
        require(msg.value > 0, "O valor depositado deve ser maior que zero");
        
        // Verificar se o depósito excede o limite do banco
        if (totalDeposits + msg.value > bankCap) {
            emit FailedDeposit(msg.sender, msg.value, "Deposito excede o limite do banco");
            revert("Deposito excede o limite do banco");
        }
        
        // Atualizar saldo do usuário e total do banco
        userBalances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        
        // Emitir evento de depósito bem-sucedido
        emit Deposit(msg.sender, msg.value, userBalances[msg.sender]);
    }
    
    function withdraw(uint256 amount) external {
        // Verificar se o valor é maior que zero
        require(amount > 0, "O valor do saque deve ser maior que zero");
        
        // Verificar se o usuário tem saldo suficiente
        if (userBalances[msg.sender] < amount) {
            emit FailedWithdrawal(msg.sender, amount, "Saldo insuficiente");
            revert("Saldo insuficiente para saque");
        }
        
        // Atualizar saldo do usuário e total do banco
        userBalances[msg.sender] -= amount;
        totalDeposits -= amount;
        
        // Transferir fundos para o usuário
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Falha na transferencia ETH");
        
        // Emitir evento de saque bem-sucedido
        emit Withdrawal(msg.sender, amount, userBalances[msg.sender]);
    }
    
    function getUserBalance() external view returns (uint256) {
        return userBalances[msg.sender];
    }
    
    function getBankBalance() external view returns (uint256) {
        return totalDeposits;
    }
    
    function getBankCap() external view returns (uint256) {
        return bankCap;
    }
    
    function updateBankCap(uint256 newCap) external onlyOwner {
        bankCap = newCap;
    }
}
