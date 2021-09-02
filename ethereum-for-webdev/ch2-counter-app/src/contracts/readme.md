# Notes
## Step by Step Guidelines

1. `solc contracts/Counter.sol`
2. `solc --pretty-json --combined-json=abi,bin --overwrite \ -o ./build/contracts contracts/Counter.sol`