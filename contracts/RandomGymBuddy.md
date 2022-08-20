# RandomGymBuddy NFT contract deployments doc


### example NFT Storage url by using ipfs and nft.storage

- ipfs://bafybeietlso25ekzdwzfsbdu3lknwswfrh77woxaokpduj5jaebbeomhay/gb1.png
- https://nftstorage.link/ipfs/bafybeietlso25ekzdwzfsbdu3lknwswfrh77woxaokpduj5jaebbeomhay/gb1.png
- ipfs://bafybeihb2yeriz2y5fbrxbgyvmo7k54ejzwto3qlmf3bvqj7bmwxmequkm/gb10.json

#### how to deploy it on Polygon Mumbai testnet + values needed for the contract deployment

https://docs.chain.link/docs/vrf/v2/supported-networks/#polygon-matic-mumbai-testnet

testnet subscription

https://vrf.chain.link/mumbai/1510

```
vrfCoordinatorV2: 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed
subscriptionId: 1510
gasLane: 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f
mintFee: 0.001 => 0.001 * 10 ** 18 => 1000000000000000
callbackGasLimit: 400000
```

deployments to Mumbai testnet
- 0x9Ce8A78593969Cd5281bd75A62477BaC3983789F

#### how to deploy it on Avalanche Fuji testnet + values needed for the contract deployment

https://docs.chain.link/docs/vrf-contracts/#avalanche-fuji-testnet


```
vrfCoordinatorV2: 0x2eD832Ba664535e5886b75D64C46EB9a228C2610
subscriptionId: 80
gasLane: 0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61
mintFee: 0.001 => 0.001 * 10 ** 18 => 1000000000000000
callbackGasLimit: 300000
```

- create subscription to get subscription id
- add consumer to subscription
- you can calce subscirption later

### deployed contracts change log:

- 0x7DC07BdAf411244Ca0F170B958eDee7eE435BE54
this contract had to low callbackGasLimit
- 0x63f165eB1DB0a4E1d7d5c81c3Ed48f8e38E40FF9
working contract with 
callbackGasLimit: 300000
- 0x0650c5faeaec2193f7d0744cf90993277f530b74
(with cid from files in nftstorage)

`currently deployed`
- 0xB32d869e7BF0C9DF8c2cfb4c14E8B00d462A3e9c
(with cid from files in nftstorage)
callbackGasLimit: 400000





