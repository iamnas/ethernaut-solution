# ethernaut-solution


1.Hello Ethernaut
<!-- "0xeF08E3A4FF2e36f81D0a746947C4bd68BB1A67e9" -->
 await contract.password()
 await contract.authenticate('ethernaut0')

2.Fallback
<!-- 0x12c6202f6911b88781c04986F4aB65e58b9A0585 -->
    1. Contribute some amount of ETH using contribute() function
    await contract.contribute.sendTransaction({value:toWei(".00001")})
    2. Send some eth to the contract (CALLDATA) for receive() method will triggered and has to be require condtion satisfied too 
        and change the owner too when receive() will be triggered
    await contract.sendTransaction({value:toWei(".0001")})
    3. withdraw call to reduce its balance to 0
    await contract.withdraw()

3.Fallout
<!-- 0x1D34c5e3320f5D9bc5fC8079685C5F2fb1a54B8f -->
await contract.Fal1out()

    That was silly wasn't it? Real world contracts must be much more secure than this and so must it be much harder to hack them right?

    Well... Not quite.

    The story of Rubixi is a very well known case in the Ethereum ecosystem. The company changed its name from 'Dynamic Pyramid' to 'Rubixi' but somehow they didn't rename the constructor method of its contract:

    contract Rubixi {
    address private owner;
    function DynamicPyramid() { owner = msg.sender; }
    function collectAllFees() { owner.transfer(this.balance) }
    ...
    This allowed the attacker to call the old constructor and claim ownership of the contract, and steal some funds. Yep. Big mistakes can be made in smartcontractland.

4. Coin Flip
    Generating random numbers in solidity can be tricky. There currently isn't a native way to generate them, and everything you use in smart contracts is publicly visible, including the local variables and state variables marked as private. Miners also have control over things like blockhashes, timestamps, and whether to include certain transactions - which allows them to bias these values in their favor.

    To get cryptographically proven random numbers, you can use Chainlink VRF, which uses an oracle, the LINK token, and an on-chain contract to verify that the number is truly random.

    Some other options include using Bitcoin block headers (verified through BTC Relay), RANDAO, or Oraclize).

5.Telephone
<!-- 0xb17c2d73Bb8FfBF052a2d441ef6758285eabFCa8 -->
    While this example may be simple, confusing tx.origin with msg.sender can lead to phishing-style attacks, such as this.

    An example of a possible attack is outlined below.

    1.Use tx.origin to determine whose tokens to transfer, e.g.
        function transfer(address _to, uint _value) {
            tokens[tx.origin] -= _value;
            tokens[_to] += _value;
        }
    2.Attacker gets victim to send funds to a malicious contract that calls the transfer function of the token contract, e.g.
        function () payable {
            token.transfer(attackerAddress, 10000);
        }
    
    3.In this scenario, tx.origin will be the victim's address (while msg.sender will be the malicious contract's address),
      resulting in the funds being transferred from the victim to the attacker. 


6.Token
<!-- 0xC16237e24c6A1377b8A0a41e520c7D1E5c122863 -->
    await contract.transfer("address",21)

    Overflows are very common in solidity and must be checked for with control statements such as:

    if(a + c > a) {
    a = a + c;
    }
    An easier alternative is to use OpenZeppelin's SafeMath library that automatically checks for overflows in all the mathematical operators. The resulting code looks like this:

    a = a.add(c);
    If there is an overflow, the code will revert.

7.Delegate
<!-- 0xE1F15e570836872154aaaF1aA4B2D867c0b0264c -->
abi.encodeWithSignature("pwn()") is dd365b8b

await contract.sendTransaction({from: player, data: "dd365b8b"})

8 Forse
<!-- 0x32f8DCA769F10B9466b71f3FCBd3EC7258700c1a -->

    In solidity, for a contract to be able to receive ether, the fallback function must be marked payable.

    However, there is no way to stop an attacker from sending ether to a contract by self destroying. Hence, it is important not to count on the invariant address(this).balance == 0 for any contract logic.

9 Vault
<!-- 0xdFF1a558c01ee357a27E1AbF825d4bCfD6a00C9B -->
web3.eth.getStorageAt(contractAddress, 1, (e, v) => console.log(web3.utils.toAscii(v)));
web3.eth.getStorageAt(contractAddress, 1)
await contract.unlock(web3.eth.getStorageAt(contractAddress, 1))
    or
await contract.unlock('0x412076657279207374726f6e67207365637265742070617373776f7264203a29')

10 King
<!-- 0x6848C1951fB6bb65d5168B2609820DEB3F6b4b48 -->

11

12 Elevator
<!-- 0x6Cf4882c86753a32B03c9343Ba80B3A6f5BB6117 -->
    You can use the view function modifier on an interface in order to prevent state modifications. The pure modifier also prevents functions from modifying the state. Make sure you read Solidity's documentation and learn its caveats.

    An alternative way to solve this level is to build a view function which returns different results depends on input data but don't modify state, e.g. gasleft().

13 Privacy
<!-- 0x55E4Ef0F53b13AbF16384827dAD6C385ce5c58b7 -->

 const keyData = await web3.eth.getStorageAt(contract.address, 5, console.log)

 const key16 = keyData.slice(0, 34)

 14 GatekeeperOne


 16
 NaughtCoin
 <!-- 0x53732c8ef2867d6855598ACD7D7aBd0C48Cc0637 -->

For this challenge, you need to be familiar with ERC20 tokens and their functions. The challenge consists of a lockup contract inheriting from ERC20 tokens. Its transfer function has been overwritten to check that one can only withdraw tokens after some time has passed. However, transfer is not the only function in ERC20 that allows for moving tokens. We can combine allow and transferFrom to transfer tokens. Both functions exist on the lockup contract in their original form due to inheritance and have not been explicitly overwritten.


 When using code that's not your own, it's a good idea to familiarize yourself with it to get a good understanding of how everything fits together. This can be particularly important when there are multiple levels of imports (your imports have imports) or when you are implementing authorization controls, e.g. when you're allowing or disallowing people from doing things. In this example, a developer might scan through the code and think that transfer is the only way to move tokens around, low and behold there are other ways of performing the same operation with a different implementation.


 22 Shop
 
 Contracts can manipulate data seen by other contracts in any way they want.

 It's unsafe to change the state based on external and untrusted contracts logic.