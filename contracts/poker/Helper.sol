// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
// import "./ERC20.sol";

// contract Helper is VRFConsumerBase {
//     bytes32 public keyHash;
//     uint256 public fee;
//     uint256 public randomResult;

//     constructor()
//         public
//         VRFConsumerBase(
//             0x6168499c0cFfCaCD319c818142124B7A15E857ab, // VRF Coordinator
//             0x01BE23585060835E02B77ef475b0Cc51aA1e0709 // LINK Token
//         )
//     {
//         keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
//         fee = 100000000000000000;
//     }

//     function getRandomNumber() public returns (bytes32 requestId) {
//         return requestRandomness(keyHash, fee);
//     }

//     function fulfillRandomness(
//         bytes32 requestId,
//         uint256 randomness
//     ) internal override {
//         randomResult = randomness;
//     }
//     // function isERC20(address _tokenAddress) public view returns (bool) {
//     //     ERC20 token = ERC20(_tokenAddress);
//     //     return token.supportsInterface(0x36372b07);
//     // }
// }
