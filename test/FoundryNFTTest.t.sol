// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import { FoundryNFT } from "../src/FoundryNFT.sol";

error SendEtherFailed();

contract FoundryNFTTest is Test {
    FoundryNFT f_nft;

    function setUp() public {
        f_nft = new FoundryNFT("FoundryNFT", "FNFT", "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/");
    }

    function testMintTo(address recipient) public {
        vm.deal(recipient, 1 ether);
        vm.prank(recipient);
        f_nft.mintTo{value: 0.08 ether}(recipient);
        assertEq("ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/1", f_nft.tokenURI(1));
    }

    function testWithdrawPayments() public {
        address owner = f_nft.owner();
        console.log("The Deployer address:", owner);
        address recipient = address(3);
        vm.deal(recipient, 1 ether);
        vm.prank(recipient);
        console.log("The recipient address:", recipient);
        console.log("recipient Balance is:", recipient.balance);

        f_nft.mintTo{value: 0.08 ether}(recipient);
        console.log("The f_nft url:", f_nft.tokenURI(1));

        vm.prank(owner);
        f_nft.withdrawPayments(payable(recipient));
        assertEq(1 ether, recipient.balance);
    }

    function testFailMintTo(address recipient) public {
        uint256 balance = recipient.balance;
        vm.assume(balance < 0.08 ether);
        vm.prank(recipient);
        f_nft.mintTo{value: 0.08 ether}(recipient);
    }

    function testFailWithdrawPayments(address recipient) public {
        vm.assume(recipient != f_nft.owner());
        vm.prank(recipient);
        f_nft.withdrawPayments(payable(recipient));
    }
}