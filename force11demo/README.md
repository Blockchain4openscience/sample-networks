# demo for force11 workshop
simple system to publish hashed hypotheses

it holds 2 contracts:

**Document.sol** which stores hashed information on a secret hypothesis, that
only the author can reveal. Also the author has the ability to add (but not
remove) worklogs to the hypothesis (in the form of bytes32 objects, e.g. IPFS
hashes of pieces of data).

**DocumentRegistry.sol**, which is a the central place via which all hypotheses
must be created. Can be used to check whether Documents have truly been created
by the Registry and to look up all hypotheses associated to an address.

## Requirements

requires to install [truffle](http://truffleframework.com/)

## Usage

command line:

run 'truffle develop' to launch a local blockchain

type 'migrate' to deploy contracts

run 'truffle test' to test them

