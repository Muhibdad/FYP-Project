// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRealEstate {
  event PropertyCreated(uint256 id, address owner, uint256 price);
  event PropertyApproved(uint256 id);
  event PropertySold(uint256 id, address buyer, uint256 price);

  function createProperty(string memory uri, uint256 price) external;
}
