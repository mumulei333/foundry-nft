//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import { Script, console } from "forge-std/Script.sol";
import { FoundryNFT } from "../src/FoundryNFT.sol";

contract DeployFoundryNFT is Script {
    function run() external {

        address deployer = vm.addr(vm.envUint("PRIVATE_KEY"));
        console.log("The Deployer address:", deployer);
        console.log("Balance is:", deployer.balance);

        vm.startBroadcast(deployer);
        FoundryNFT nft = new FoundryNFT("FoundryNFT", "FNFT", "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/");
        vm.stopBroadcast();

        console.log("FoundryNFT deployed at:", address(nft));
    }
}