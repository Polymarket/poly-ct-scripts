# poly-ct-scripts

Scripts to help you interact with the Conditional Tokens contracts.

## Foundry

This project uses Foundry. For more information, see the [Foundry Book](https://book.getfoundry.sh).

To install on macOS or Linux, first download `foundryup`:

```[bash]
curl -L https://foundry.paradigm.xyz | bash
```

Then, install Foundry by running:

```[bash]
foundryup
```

For other installation types, see the Foundry Book's [installation instructions](https://book.getfoundry.sh/getting-started/installation).

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

To make a random new wallet execute `cast wallet new`.

## Mumbai

### Faucet

To get Mumbai Matic (or Goërli ETH)
visit [https://faucet.polygon.technology](https://faucet.polygon.technology)

### USDC

The USDC contract on Mumbai is mintable with signature `"mint(address,uint256)"`. In particular, it implements `src/interfaces/IERC20Mintable.sol`.
