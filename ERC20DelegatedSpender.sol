// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title ERC20 Delegated Token Spender
/// @notice This contract allows transferring ERC20 tokens from user wallets to this contract using approved allowances.

interface IERC20 {
    // Returns the token balance of a specific account
    function balanceOf(address account) external view returns (uint256);

    // Transfers tokens from caller to recipient
    function transfer(address recipient, uint256 amount) external returns (bool);

    // Approves a spender to transfer tokens on behalf of the caller
    function approve(address spender, uint256 amount) external returns (bool);

    // Returns the remaining number of tokens a spender is allowed to spend
    function allowance(address owner, address spender) external view returns (uint256);

    // Transfers tokens from one address to another using allowance
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract TokenSpender {
    // The address of the ERC20 token this contract interacts with
    address public tokenAddres;

    /// @notice Transfers tokens from a user's wallet into this contract using allowance
    /// @param from The address of the user who approved the allowance
    /// @param amount The amount of tokens to transfer
    function spendToken(address from, uint256 amount) external {
        IERC20 token = IERC20(tokenAddres); // Initialize token interface
        uint256 allowed = token.allowance(from, address(this)); // Check how much the contract is allowed to spend
        require(allowed >= amount, "Insufficient allowance"); // Ensure the allowance is sufficient

        // Attempt to transfer the tokens from user's wallet to this contract
        bool success = token.transferFrom(from, address(this), amount);
        require(success, "Transfer failed"); // Ensure the transfer succeeded
    }

    /// @notice Returns the token balance of any given address
    /// @param user The address to query balance for
    /// @return The token balance of the provided user address
    function contractBalance(address user) external view returns (uint256) {
        IERC20 token = IERC20(tokenAddres); // Initialize token interface
        return token.balanceOf(user); // Return the balance of the specified user
    }
}
