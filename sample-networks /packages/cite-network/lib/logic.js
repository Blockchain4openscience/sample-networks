/**
 * Track the citations of a bibliographic reference from one researcher
 * @param {org.acme.cite.Cite} citation - the citation to be processed
 * @transaction
 */
function tradeCommodity(citation) {
    citation.bibRef.citations = citation.bibRef.citations + 1;
    return getAssetRegistry('org.acme.cite.BibRef')
        .then(function (assetRegistry) {
            return assetRegistry.update(citation.bibRef);
        });
}

