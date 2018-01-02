var DocumentRegistry = artifacts.require("DocumentRegistry");
var Document = artifacts.require("Document");

var accounts = web3.eth.accounts

contract("Document Tests", function(accounts) {
    var doc;
    var createdDocAddress;
    var hypothesis = {clear: "sky is green", secret: ""}
    hypothesis.secret = web3.sha3(hypothesis.clear)

    describe("Publishing", async () => {
        it("Users can publish a document with a secret hypothesis", async () => {
            docReg = await DocumentRegistry.deployed();
            txResult = await docReg.createDocument(hypothesis.secret, {from: accounts[0]})
            // console.log(txResult.logs[0].args)
            createdDocAddress = txResult.logs[0].args.documentAddress;
            console.log("document created at address", createdDocAddress)
            exists = await docReg.documentExists.call(createdDocAddress)
            assert.isTrue(exists, "document not known to DocumentRegistry")
        })

        it ("and are registered as the owner", async () => {
            doc =  await Document.at(createdDocAddress)
            owner = await doc.owner.call()
            assert.equal(owner, accounts[0])
            // docregaddy = await doc.registeredIn.call() //TODO
            // console.log(docregaddy )
        })
    })

    describe( "revealing fails", async () => {
        it("if the owner submits the wrong hypothesis", async () => {
            try {
                await doc.revealHypothesis("sdfsdfdsf", {from:accounts[0]})
            } catch(e) {
                assert(e.toString().indexOf('invalid opcode') > 0, "no error was thrown")
            }
        })
        it("if it is tried by someone other than the owner", async () => {
            try {
                await doc.revealHypothesis(hypothesis.clear, {from:accounts[1]})
            } catch(e) {
                assert(e.toString().indexOf('invalid opcode') > 0, "no error thrown")
            }
        })
    })
    describe("Owners can ", async () => {

        it ("reveal the hypothesis of their own Documents", async () => {
            await doc.revealHypothesis(hypothesis.clear, {from:accounts[0]})
            hyp = await doc.hypothesis.call()
            // console.log(hyp)
            assert(hyp[1], hypothesis.clear, "revealed hypothesis is not correct")
        })

        it("change the status of their hypothesis", async () => {
            statusBefore = (await doc.hypothesis.call())[2]
            newStatus = 2
            await doc.setStatus(newStatus)
            statusAfter = (await doc.hypothesis.call())[2]
            assert.notEqual(statusAfter, statusBefore, "status didnt change")
            assert.equal(statusAfter, newStatus, "status didnt change")
        })
    })

})
