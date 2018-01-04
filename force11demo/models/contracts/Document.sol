pragma solidity ^0.4.13;

contract Document {
    address public owner;
    address public registeredIn;
    bytes32[] public logs;

    Hypothesis public hypothesis;

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

    function Document(bytes32 _hypothesis, address _owner) {
        hypothesis = Hypothesis(_hypothesis, "", Status.Open, now);
        owner = _owner;
        registeredIn = msg.sender;
    }

    function addLog(bytes32 _log) {
        require(msg.sender == owner);
        logs.push(_log);
    }

    function revealHypothesis(string _statement) {
        require(msg.sender == owner);
        bytes32 hash = sha3(_statement);
        require(hash == hypothesis.secret);
        hypothesis.clearText = _statement;
    }

    function setStatus(Status _status) {
        require(msg.sender == owner);
        hypothesis.state = _status;
    }
}
