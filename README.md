# poly-ct-scripts

Scripts to help you interact with the Conditional Tokens contracts.

## Wallets

To make a random wallet execute `cast wallet new`.

## Mumbai

### Deployments

On Mumbai the following deployments are live.

```[yaml]
USDC: 0x2E8DCfE708D44ae2e406a1c02DFE2Fa13012f961
CTF: 0x7d8610e9567d2a6c9fbf66a5a13e9ba8bb120d43
ConditionId: "0xbd31dc8a20211944f6b70f31557f1001557b59905b7738480ca09bd4532f84af"
YES tokenID: 16678291189211314787145083999015737376658799626183230671758641503291735614088
NO tokenID: 1343197538147866997676250008839231694243646439454152539053893078719042421992
```

The USDC contract is mintable with signature "mint(address,uint256)". In particular, it implements `src/interfaces/IERC20Mintable.sol".

### Faucet

To get Mumbai Matic (or Goërli ETH)
visit [https://faucet.polygon.technology](https://faucet.polygon.technology)
