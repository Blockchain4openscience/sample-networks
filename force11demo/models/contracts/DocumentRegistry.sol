pragma solidity ^0.4.13;

import "./Document.sol";

contract DocumentRegistry {
   mapping (address => bool) public documentExists;
   mapping (address => address[]) public allDocs;

   event newDocumentCreated(address owner, address documentAddress);

   function createDocument(bytes32 _hypothesis) {
       Document doc = new Document(_hypothesis, msg.sender);
       documentExists[address(doc)] = true;
       allDocs[msg.sender].push(address(doc));
       newDocumentCreated(msg.sender, address(doc));
   }
}

