//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Greeter  {
    string public yourName;  // data
    
    /* This runs when the contract is executed */
   constructor() {
        yourName = "World";
    } 
   
   
    function set(string memory name) public {
        yourName = name;

    }
    
    function hello() public view returns(string memory) {
        return (yourName);
    }
}
