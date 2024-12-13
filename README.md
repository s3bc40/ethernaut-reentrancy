# Ethernaut Reentrancy CTF

Challenge done in Vyper:
- using inline interface
- interacting with a Solidity contract
- IDE: Remix -> I couldn't use a `.vyi` or `.json` ABI file

That was a good experience to apply theorical knowledge from Cyfrin course.

[The level](https://ethernaut.openzeppelin.com/level/0x2a24869323C0B13Dff24E196Ba072dC790D52479)
> In order to prevent re-entrancy attacks when moving funds out of your contract, use the Checks-Effects-Interactions pattern being aware that call will only return false without interrupting the execution flow. Solutions such as ReentrancyGuard or PullPayment can also be used.