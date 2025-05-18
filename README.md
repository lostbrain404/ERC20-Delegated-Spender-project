# ERC20DelegatedSpender

Smart contract for securely pulling ERC-20 tokens from user wallets via approved allowances.

## 📘 Overview

`ERC20DelegatedSpender` is a minimalistic smart contract that allows any external caller to trigger the transfer of ERC-20 tokens **from a user’s wallet to this contract**, provided the user has **granted an allowance**.

This contract is useful for:
- DApps that require on-chain token pulling logic
- Automated token collection from multiple users
- Custodial services and vaults

## ⚙️ Features

- ✅ Pull tokens via `transferFrom` using ERC-20 allowance
- ✅ Query any user's token balance

## 🧱 Contract Structure

### `tokenAddres`
A public state variable representing the target ERC-20 token contract. This must be set in the contract deployment phase (or upgraded if mutable in future versions).

### `spendToken(address from, uint256 amount)`
Transfers `amount` of tokens from the `from` address into this contract, using the ERC-20 `transferFrom` function. Requires:
- `allowance(from, this_contract) >= amount`

### `contractBalance(address user)`
Returns the token balance of any `user` by calling `balanceOf(user)` on the ERC-20 contract.

## 🔐 Security Notes

- This contract **does not perform any owner checks**, so **anyone** can call `spendToken` as long as the allowance is given by the `from` address.
- The contract does not provide a withdrawal mechanism — tokens sent to the contract remain there unless extended in a future version.

## 📝 Example Use Case

1. User calls `approve(spenderContract, 100)` on the ERC-20 token.
2. Any external actor (such as a DApp backend or user) calls `spendToken(userAddress, 100)`.
3. Tokens are moved from the user's wallet to the contract.

## 📄 License

MIT License — free to use, modify, and distribute.
