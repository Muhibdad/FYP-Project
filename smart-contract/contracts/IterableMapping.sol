// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library IterableMapping {
  // Iterable mapping from uint256 to uint;
  struct Property {
    uint256 id;
    address owner;
    uint256 price;
    bool approved;
  }

  struct Map {
    uint256[] keys;
    mapping(uint256 => Property) values;
    mapping(uint256 => uint) indexOf;
    mapping(uint256 => bool) inserted;
  }

  function get(
    Map storage map,
    uint256 key
  ) internal view returns (Property memory) {
    return map.values[key];
  }

  function getKeyAtIndex(
    Map storage map,
    uint index
  ) internal view returns (uint256) {
    return map.keys[index];
  }

  function size(Map storage map) internal view returns (uint) {
    return map.keys.length;
  }

  function add(Map storage map, uint256 key, Property memory val) internal {
    if (map.inserted[key]) {
      map.values[key] = val;
    } else {
      map.inserted[key] = true;
      map.values[key] = val;
      map.indexOf[key] = map.keys.length;
      map.keys.push(key);
    }
  }

  function approve(Map storage map, uint256 key) internal {
    map.values[key].approved = true;
  }

  function remove(Map storage map, uint256 key) internal {
    if (!map.inserted[key]) {
      return;
    }

    delete map.inserted[key];
    delete map.values[key];

    uint index = map.indexOf[key];
    uint lastIndex = map.keys.length - 1;
    uint256 lastKey = map.keys[lastIndex];

    map.indexOf[lastKey] = index;
    delete map.indexOf[key];

    map.keys[index] = lastKey;
    map.keys.pop();
  }
}
