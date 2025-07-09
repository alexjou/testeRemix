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
    
    /**
     * @dev Constructor that sets the maximum bank limit
     * @param _bankCap The maximum bank limit in wei
     * IMPORTANT: For 1 complete ETH, use 1000000000000000000 (1 followed by 18 zeros)
     * Example: To set 5 ETH as the limit: 5000000000000000000
     */
    constructor(uint256 _bankCap) {
        owner = msg.sender;
        bankCap = _bankCap;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this action");
        _;
    }
    
    function deposit() external payable {
        // Check if the value is greater than zero
        require(msg.value > 0, "The deposited value must be greater than zero");
        
        // Check if the deposit exceeds the bank's limit
        if (totalDeposits + msg.value > bankCap) {
            emit FailedDeposit(msg.sender, msg.value, "Deposit exceeds the bank's limit");
            revert("Deposit exceeds the bank's limit");
        }
        
        // Update user balance and bank total
        userBalances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        
        // Emit successful deposit event
        emit Deposit(msg.sender, msg.value, userBalances[msg.sender]);
    }
    
    function withdraw(uint256 amount) external {
        // Check if the value is greater than zero
        require(amount > 0, "The withdrawal amount must be greater than zero");
        
        // Check if the user has sufficient balance
        if (userBalances[msg.sender] < amount) {
            emit FailedWithdrawal(msg.sender, amount, "Insufficient balance");
            revert("Insufficient balance for withdrawal");
        }
        
        // Update user balance and bank total
        userBalances[msg.sender] -= amount;
        totalDeposits -= amount;
        
        // Transfer funds to the user
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");
        
        // Emit successful withdrawal event
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
