(sourcePartDesc, sourcePageDir, sourceCtxLastMMUPage, sourceCtxEndLastMMUPage : page)
(sourceContextSaveVAddr, sourceContextEndSaveVAddr : vaddr)
(idxSourceCtxInLastMMUPage, idxSourceCtxEndInLastMMUPage : index)

{{ fun s : state =>
    (* Propriétés d'isolation sur l'état *)
    partitionsIsolation s /\
    kernelDataIsolation s /\
    verticalSharing s /\
    consistency s /\

    (* Propriété validant le descripteur de partition et son espace d'adressage *)
    In sourcePartDesc (StateLib.getPartitions pageRootPartition s) /\
    nextEntryIsPP sourcePartDesc idxPageDir sourcePageDir s /\

    (* Propriétés validant la présence et l'accessibilité de la page contenant l'adresse du début du contexte d'exécution *)
    getTableAddrRoot sourceCtxLastMMUPage idxPageDir sourcePartDesc sourceContextSaveVAddr s /\
    sourceCtxLastMMUPage <> pageDefault /\
    (forall idx : index,
        getIndexOfAddr sourceContextSaveVAddr levelMin = idx ->
        isPE sourceCtxLastMMUPage idx s) /\
    getIndexOfAddr sourceContextSaveVAddr levelMin = idxSourceCtxInLastMMUPage /\
    entryPresentFlag sourceCtxLastMMUPage idxSourceCtxInLastMMUPage true s /\
    entryUserFlag sourceCtxLastMMUPage idxSourceCtxInLastMMUPage true s /\

    (* Propriétés validant la présence et l'accessibilité de la page contenant l'adresse de fin du contexte d'exécution *)
    getTableAddrRoot sourceCtxEndLastMMUPage idxPageDir sourcePartDesc  sourceContextEndSaveVAddr s /\
    sourceCtxEndLastMMUPage <> pageDefault /\
    (forall idx : index,
        getIndexOfAddr sourceContextEndSaveVAddr levelMin = idx ->
        isPE sourceCtxEndLastMMUPage idx s) /\
    getIndexOfAddr sourceContextEndSaveVAddr levelMin = idxSourceCtxEndInLastMMUPage /\
    entryPresentFlag sourceCtxEndLastMMUPage idxSourceCtxEndInLastMMUPage true s /\
    entryUserFlag sourceCtxEndLastMMUPage idxSourceCtxEndInLastMMUPage true s
}}
