//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22; 
// Imagine a big integer that the whole world could share
contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint)  {
        return storedData;
    }
    
    function increment (uint n) public {
        storedData = storedData + n;
        return;
    }
    
    function decrement (uint n) public {
        storedData = storedData - n;
        return;
    }
    
}

 


