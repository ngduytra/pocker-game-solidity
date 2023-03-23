const Poker = artifacts.require("Poker");
const Token = artifacts.require("Token");

contract("Poker", (accounts) => {
  let [alice, bob] = accounts;
  let contractInstance;
  let tokenInstance;
  let battleId;
  let winner;

  before(async () => {
    contractInstance = await Poker.new();
    tokenInstance = await Token.new();
    await tokenInstance.approve(alice, 50000000000);
    await tokenInstance.transferFrom(alice, bob, 50000000000);
  });

  it("should start a battle", async () => {
    await tokenInstance.approve(contractInstance.address, 10000, {
      from: alice,
    });

    const result = await contractInstance.createBattle(
      tokenInstance.address,
      10000,
      {
        from: alice,
      }
    );

    // await tokenInstance.assert.equal(result.receipt.status, true);
    battleId = result.logs[1].args.id;
    assert.equal(result.logs[1].args.betToken, tokenInstance.address);
  });

  it("join a battle", async () => {
    await tokenInstance.approve(contractInstance.address, 10000, { from: bob });

    const result = await contractInstance.joinBattle(battleId, {
      from: bob,
    });

    assert.equal(result.logs[1].args.betToken, tokenInstance.address);
  });

  it("Execute a battle", async () => {
    const result = await contractInstance.executeBattle(battleId, {
      from: alice,
    });

    winner = result.logs[0].args.winner;

    console.log("randomNumberr => ", result.logs[0].args.aa.toString());
    assert.equal(result.logs[0].args.betToken, tokenInstance.address);
  });

  it("claim a battle", async () => {
    // await tokenInstance.approve(contractInstance.address, 10000);

    const result = await contractInstance.claimBattle(battleId, {
      from: winner,
    });

    assert.equal(result.logs[1].args.battle.toString(), battleId);
  });
});
