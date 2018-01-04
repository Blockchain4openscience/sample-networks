pragma solidity ^0.4.13;

/*
  "Document" class to store hashed information for work related to a secret hyptothesis
*/
contract Document {
    // author of the hypothesis
    address public owner;
    // it's central registry
    address public registeredIn;
    // an array of logs
    bytes32[] public logs;

    // the hypothesis
    Hypothesis public hypothesis;

    /* Data structure to store info on the hypothesis:
       - hashed secret
       - hypothesis in clear text
       - date of publication
      (- Status: confirmed, ongoing, rejected)
     */
    struct Hypothesis {
        bytes32 secret;
        string clearText;
        Status state;
        uint date;
    }

    enum Status {
        Open,
        Confirmed,
        Rejected
    }


    /* Constructor to create a hypothesis with minimal necessary information:
       @param: a secret and
       @param: the inventor/owner
    */
    function Document(bytes32 _hypothesis, address _owner) {
        hypothesis = Hypothesis(_hypothesis, "", Status.Open, now);
        owner = _owner;
        registeredIn = msg.sender;
    }

    /*
      function to reveals a hypothesis by submitting it in cleartext
      @param: string _statement
    */
    function revealHypothesis(string _statement) {
        require(msg.sender == owner);
        bytes32 hash = sha3(_statement);
        require(hash == hypothesis.secret);
        hypothesis.clearText = _statement;
    }

    /*
      function to update the status of an hypothesis to
      be ongoing, confirmed or rejected
      @param: string _status
    */
    function setStatus(Status _status) {
        require(msg.sender == owner);
        hypothesis.state = _status;
    }

    /*
      function to add a hashed log entry to the document
      @param bytes32 hashed logentry
    */
    function addLog(bytes32 _log) {
        require(msg.sender == owner);
        logs.push(_log);
    }
}
