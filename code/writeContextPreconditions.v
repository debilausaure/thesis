(* Paramètres *)
(sourcePartDesc, ctxMMUPage, ctxEndMMUPage : page)
(contextSaveAddr, contextEndSaveAddr : vaddr)
(idxCtxMMUPage, idxCtxEndMMUPage : index)
(s : state)

   (* Propriété d'isolation *)
   partitionsIsolation s
/\ kernelDataIsolation s
/\ verticalSharing s
/\ consistency s

   (* Propriété indiquant que la partition est valide *)
/\ In sourcePartDesc (getPartitions pageRootPartition s)

   (* Propriété indiquant que contextSaveAddr est présent *)
   (* et accessible dans l'espace d'adressage             *)
/\ getTableAddrRoot ctxMMUPage idxPageDir sourcePartDesc
                                          contextSaveAddr s
/\ ctxMMUPage <> pageDefault
/\ getIndexOfAddr contextSaveAddr levelMin = idxCtxMMUPage
/\ isPE ctxMMUPage idxCtxMMUPage s
/\ entryPresentFlag ctxMMUPage idxCtxMMUPage true s
/\ entryUserFlag ctxMMUPage idxCtxMMUPage true s

   (* Propriété indiquant que contextSaveEndAddr est présent *)
   (* et accessible dans l'espace d'adressage                *)
/\ getTableAddrRoot ctxEndMMUPage idxPageDir sourcePartDesc
                                             contextEndSaveAddr s
/\ ctxEndMMUPage <> pageDefault
/\ getIndexOfAddr contextEndSaveAddr levelMin = idxCtxEndMMUPage
/\ isPE ctxEndMMUPage idxCtxEndMMUPage s
/\ entryPresentFlag ctxEndMMUPage idxCtxEndMMUPage true s
/\ entryUserFlag ctxEndMMUPage idxCtxEndMMUPage true s
