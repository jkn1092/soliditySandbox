const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("Voting", function () {

  async function deployVoting() {
    const accounts = await ethers.getSigners();
    const admin = accounts[0];
    const voters = [];

    for (const account of accounts.slice(1,5)) {
      voters.push(account);
    }

    const Voting = await ethers.getContractFactory("Voting");
    const voting = await Voting.deploy();

    return { voting, admin, voters };
  }

  describe("RegisteringVoters Workflow", function () {

    it('workflowStatus should be at 0 = RegisteringVoters', async function () {
      const { voting } = await loadFixture(deployVoting);

      const status = await voting.workflowStatus.call();
      expect(status).to.equal(0);
    });

    it('should revert with not allowed', async function () {
      const { voting, voters } = await loadFixture(deployVoting);

      await expect(voting.connect(voters[0]).addVoter(voters[0].address))
          .to.be.reverted;
    });

    it('should emit events VoterRegistered', async function () {
      const { voting, admin, voters } = await loadFixture(deployVoting);

      for (const voterAddress of Object.values(voters) ) {
        let result = await voting.connect(admin).addVoter(voterAddress.address);
        await expectEvent(result, 'VoterRegistered',{ voterAddress: voterAddress });
      }
    });
  });
});
