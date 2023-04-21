from web3 import Web3
from web3.contract import Contract

import os


ETH_ACCOUNT_PRIVATE_KEY = os.environ.get("ETH_ACCOUNT_PRIVATE_KEY")
WEB3_PROVIDER_URI=os.environ.get("WEB3_PROVIDER_URI")
CONTRACT_REGISTRY_ADDRESS = os.environ.get("CONTRACT_REGISTRY_ADDRESS")
ACCESS_ACTION_ADDRESS = os.environ.get("ACCESS_ACTION_ADDRESS")
CONTRACT_REGISTRY_JSON_PATH = "out/ContractRegistry.sol/ContractRegistry.json"

def get_web3() -> Web3:
    from web3.middleware import geth_poa_middleware
    web3 = Web3(Web3.HTTPProvider(WEB3_PROVIDER_URI))
    web3.middleware_onion.inject(geth_poa_middleware, layer=0)
    return web3


def load_contract_from_json(file_path: str) -> Contract:
    """
    Loads a contract from its solidity file
    :param file_path: Path to the contract file
    :returns: Contract instance
    :raises: Exception : If exception in compiling contract
    """
    import json

    file_path = os.path.join(file_path)
    if not os.path.exists(file_path):
        raise FileNotFoundError("File not found at expected location " + file_path)
    with open(file_path) as json_file:
        data = json.load(json_file)
        if 'abi' not in data:
            raise KeyError("ABI not found in " + file_path)
        if 'bytecode' not in data:
            raise KeyError("Bytecode not found in " + file_path)

    return data

def verify_access_action_addr(addr: str) -> bool:
    web3 = get_web3()
    contract_registry = load_contract_from_json(CONTRACT_REGISTRY_JSON_PATH)
    contract_registry = web3.eth.contract(address=CONTRACT_REGISTRY_ADDRESS, abi=contract_registry['abi'])
    print("Access ACtion address ", contract_registry.functions.getAccessActionAddress().call())
    access_action_addr = contract_registry.functions.getAddress('ACCESS_ACTION').call()
    if access_action_addr != addr:
        raise ValueError("Access Action address mismatch")

verify_access_action_addr(addr=ACCESS_ACTION_ADDRESS)