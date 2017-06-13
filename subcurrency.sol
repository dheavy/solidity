pragma solidity ^0.4.0;

contract Coin {
    // Declares a publicly accessible state variable of type `address`,
    // a 160-bit value not allowing any arithmetic operations, suitable for
    // storing addresses of contracts or keypairs owned by persons.
    address public minter;

    // Publicly accessible state variable of a complex datatype, 
    // mapping addresses to unsigned integers.
    mapping (address => uint) public balances;

    // Events allow light clients to react on changes efficiently.
    event Sent(address from, address to, uint amount);

    // Constructor code, run only when contract is created.
    // `msg` (together with `tx` and `block`) is a magic global
    // that contains some properties which allow access to the blockchain.
    // `msg.sender` is always the address where the current (external) 
    // function call came from.
    function Coin() {
        minter = msg.sender;
    }

    // If `mint` is called by anyone but the contract issuer, nothing happens.
    function mint(address receiver, uint amount) {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    // `send` can be used by anyone owning some coins, to anyone else.
    // If this contract is used to send coins to an address, you will not see 
    // anything when you look at that address on a blockchain explorer,
    // because the fact you sent coins and the changed balance are only stored
    // in the data storage of this particular coin contract.
    // Use events to track transactions and balances of your new coin.
    function send(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[msg.sender] += amount;
        Sent(msg.sender, receiver, amount);
    }
}
