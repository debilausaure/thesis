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
    List.In sourcePartDesc (StateLib.getPartitions pageRootPartition s) /\
    StateLib.nextEntryIsPP sourcePartDesc idxPageDir sourcePageDir s /\

    (* Propriétés validant la présence et l'accessibilité de la page contenant l'adresse du début du contexte d'exécution *)
    StateLib.getTableAddrRoot sourceCtxLastMMUPage idxPageDir sourcePartDesc sourceContextSaveVAddr s /\
    sourceCtxLastMMUPage <> pageDefault /\
    (forall idx : index,
        StateLib.getIndexOfAddr sourceContextSaveVAddr levelMin = idx ->
        StateLib.isPE sourceCtxLastMMUPage idx s) /\
    StateLib.getIndexOfAddr sourceContextSaveVAddr levelMin = idxSourceCtxInLastMMUPage /\
    StateLib.entryPresentFlag sourceCtxLastMMUPage idxSourceCtxInLastMMUPage true s /\
    StateLib.entryUserFlag sourceCtxLastMMUPage idxSourceCtxInLastMMUPage true s /\

    (* Propriétés validant la présence et l'accessibilité de la page contenant l'adresse de fin du contexte d'exécution *)
    StateLib.getTableAddrRoot sourceCtxEndLastMMUPage idxPageDir sourcePartDesc  sourceContextEndSaveVAddr s /\
    sourceCtxEndLastMMUPage <> pageDefault /\
    (forall idx : index,
        StateLib.getIndexOfAddr sourceContextEndSaveVAddr levelMin = idx ->
        StateLib.isPE sourceCtxEndLastMMUPage idx s) /\
    StateLib.getIndexOfAddr sourceContextEndSaveVAddr levelMin = idxSourceCtxEndInLastMMUPage /\
    StateLib.entryPresentFlag sourceCtxEndLastMMUPage idxSourceCtxEndInLastMMUPage true s /\
    StateLib.entryUserFlag sourceCtxEndLastMMUPage idxSourceCtxEndInLastMMUPage true s
}}
