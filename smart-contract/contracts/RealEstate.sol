// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./IterableMapping.sol";
import "./IRealEstate.sol";

contract RealEstate is ERC721, ERC721URIStorage, AccessControl, IRealEstate {
  using IterableMapping for IterableMapping.Map;
  using Counters for Counters.Counter;

  bytes32 public constant APPROVE_ROLE = keccak256("APPROVE_ROLE");
  Counters.Counter private _tokenIdCounter;
  IterableMapping.Map private _properties;

  struct Property {
    uint256 id;
    address owner;
    uint256 price;
    bool approved;
  }

  constructor() ERC721("MyToken", "MTK") {
    _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _grantRole(APPROVE_ROLE, msg.sender);
  }

  // Function to create a new property listing
  function createProperty(
    string memory uri,
    uint256 price
  ) public virtual override {
    // Calculate the next property ID
    uint256 id = uint256(
      keccak256(abi.encodePacked(msg.sender, block.timestamp))
    );

    // Create the new property and add it to the properties mapping
    uint256 tokenId = _safeMint(msg.sender, uri);
    _properties.add(
      tokenId,
      IterableMapping.Property(id, msg.sender, price, false)
    );

    // Emit an event to log the property creation
    emit PropertyCreated(id, msg.sender, price);
  }

  function approveProperty(uint256 _propertyId) public onlyRole(APPROVE_ROLE) {
    require(
      _properties.get(_propertyId).owner != address(0),
      "Invalid property ID"
    );
    require(
      !_properties.get(_propertyId).approved,
      "Property already approved"
    );

    _properties.approve(_propertyId);
  }

  function getProperty(
    uint256 key
  ) public view returns (IterableMapping.Property memory) {
    return _properties.get(key);
  }

  function _safeMint(
    address to,
    string memory uri
  ) private returns (uint256 tokenId) {
    tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
  }

  // The following functions are overrides required by Solidity.

  function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
    super._burn(tokenId);
  }

  function tokenURI(
    uint256 tokenId
  ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
    return super.tokenURI(tokenId);
  }

  function supportsInterface(
    bytes4 interfaceId
  ) public view override(ERC721, AccessControl) returns (bool) {
    return super.supportsInterface(interfaceId);
  }
}
