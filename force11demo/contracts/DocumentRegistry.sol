pragma solidity ^0.4.13;

import "./Document.sol";

/*
  "Registry" class to store generate Documents related to a secret hypothesis
*/
contract DocumentRegistry {

    // mapping to save all Documents associated to this registry
    mapping (address => bool) public documentExists;

    // event to notify about the creation of a new Document
    event newDocumentCreated(address owner, address documentAddress);

    // function to be called to create a new Document
    // @param _hypothesis: sha3-hash of the hypothesis in clear text
   function createDocument(bytes32 _hypothesis) returns(address){

   }

   //optional features:
   /*
     function to return the number of Documents associated to a given address
     @param _author
   */
   /* function docsOfAddress(address _author) returns(uint) { */
   /* } */

   /* function to the a specific document of a given address
       @param _author
       @param _idx the index of the document in the list of all docs
   */
   /* function docXofAddress(address _author, uint idx) returns(address) { */
   /* } */
}

