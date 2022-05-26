# RandomGymBuddy NFT contract deployments doc

#### how to deploy it on Avalanche Fuji testnet

values needed for the contract deployment

https://docs.chain.link/docs/vrf-contracts/#avalanche-fuji-testnet

vrfCoordinatorV2: 0x2eD832Ba664535e5886b75D64C46EB9a228C2610
subscriptionId: 80
gasLane: 0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61
mintFee: 0.001 => 0.001 * 10 ** 18 => 1000000000000000
callbackGasLimit: 300000

- create subscription to get subscription id
- add consumer to subscription
- you can calce subscirption later

### deployed contracts:
- 0x7DC07BdAf411244Ca0F170B958eDee7eE435BE54
this contract had to low callbackGasLimit
- 0x63f165eB1DB0a4E1d7d5c81c3Ed48f8e38E40FF9
working contract with 
callbackGasLimit: 300000

### example NFT Storage url

ipfs://bafybeietlso25ekzdwzfsbdu3lknwswfrh77woxaokpduj5jaebbeomhay/gb1.png
https://nftstorage.link/ipfs/bafybeietlso25ekzdwzfsbdu3lknwswfrh77woxaokpduj5jaebbeomhay/gb1.png

ipfs://bafybeihb2yeriz2y5fbrxbgyvmo7k54ejzwto3qlmf3bvqj7bmwxmequkm/gb10.json




