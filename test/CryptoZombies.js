// const CryptoZombies = artifacts.require("ZombieFactory");
// const utils = require("./helpers/utils");

// const zombieNames = ["Zombie 1", "Zombie 2"];
// contract("ZombieFactory", (accounts) => {
//   let [alice, bob] = accounts;
//   it("should be able to create a new zombie", async () => {
//     const contractInstance = await CryptoZombies.new();

//     const result = await contractInstance.createRandomZombie(zombieNames[0], {
//       from: alice,
//     });
//     assert.equal(result.receipt.status, true);
//     assert.equal(result.logs[0].args.name, zombieNames[0]);
//   });

//   it("should not allow two zombies", async () => {
//     // start here
//     await contractInstance.createRandomZombie(zombieNames[0], { from: alice });
//     await utils.shouldThrow(
//       contractInstance.createRandomZombie(zombieNames[1], { from: alice })
//     );
//   });
// });
