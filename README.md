# poly-ct-scripts

Scripts to help you interact with the Conditional Tokens contracts.

## Usage

Make sure to create a `.env` file following the template in `.env.example`.
Note: the conditionId is specified in the `.env` file.

```[bash]
./run.sh [OPTIONS] SCRIPT_NAME

# e.g.
./run.sh -a 1000 -b mint_usdc
./run.sh -a 500 split
./run.sh balances
```

### Options

- `-a`: Specify an amount for `mint_usdc`, `split`, and `merge` scripts.
- `-b`: Broadcast the transaction on chain. Omit to simulate the transaction locally.

### Scripts

1. `balances`: Gets USDC, conditional token, and gas token balances.
2. `mint_usdc`: Mint USDC (on Mumbai).
3. `split`: Split collateral into conditional tokens.
4. `merge`: Merge complete set of conditional tokens to collateral.

### Wallets

To make a random wallet execute `cast wallet new`.

## Mumbai

### Faucet

To get Mumbai Matic (or Goërli ETH)
visit [https://faucet.polygon.technology](https://faucet.polygon.technology)

### USDC

The USDC contract on Mumbai is mintable with signature `"mint(address,uint256)"`. In particular, it implements `src/interfaces/IERC20Mintable.sol`.

### Deployments

On Mumbai the following deployments are live.

```[yaml]
USDC: 0x2E8DCfE708D44ae2e406a1c02DFE2Fa13012f961
CTF: 0x7d8610e9567d2a6c9fbf66a5a13e9ba8bb120d43
ConditionId: "0xbd31dc8a20211944f6b70f31557f1001557b59905b7738480ca09bd4532f84af"
YESTokenID: 16678291189211314787145083999015737376658799626183230671758641503291735614088
NOTokenID: 1343197538147866997676250008839231694243646439454152539053893078719042421992
ClobAPIUrl: "https://clob-staging.polymarket.com/"
```
