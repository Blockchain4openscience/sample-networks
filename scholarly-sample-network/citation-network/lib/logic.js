/**
 * Track the citations of a bibliographic reference from one researcher
 * @param {org.acme.cite.Cite} citation - the citation to be processed
 * @transaction
 */
function tradeCommodity(citation) {
    citation.bibRef.citations++;
    return getAssetRegistry('org.acme.cite.BibRef')
        .then(function (assetRegistry) {
            return assetRegistry.update(citation.bibRef);
        });
}
/**
 * Increase in one the reward 
 * @param {org.acme.cite.Cite} citation - the citation to be processed
 * @transaction
 */
function giveReward(citation) {
    if (((citation.iniPage && citation.finPage) && citation.pieceTxt) && citation.reason){
        citation.citer.reward++;
        return getParticipantRegistry('org.acme.cite.Researcher')
   		  .then(function (participantRegistry) {
              return participantRegistry.update(citation.citer);
           });
    }
}
