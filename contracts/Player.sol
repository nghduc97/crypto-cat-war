pragma solidity ^0.4.19;

import "./Abstract.sol";

contract Player is Abstract {
    function transferCat(Cat storage cat, address newOwner) internal {
        require(cat.owner == msg.sender);

        // remove from profile
        uint[] storage ids = ownedCats[msg.sender];
        bool found = false;
        uint len = ids.length;
        for (uint i = 0; i + 1 < len; ++i) {
            if (ids[i] == cat.id) {
                found = true;
            }

            if (found) {
                ids[i] = ids[i + 1];
            }
        }
        ids.length--;

        // give to new owner
        receiveCat(cat, newOwner);
    }

    function receiveCat(Cat storage cat, address owner) internal {
        cat.owner = owner;
        ownedCats[owner].push(cat.id);
    }

    function getOwnedCats() external view returns (uint[]) {
        return ownedCats[msg.sender];
    }
}