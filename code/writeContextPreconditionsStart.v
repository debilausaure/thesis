getTableAddrRoot ctxMMUPage idxPageDir sourcePartDesc contextSaveAddr s
/\ ctxMMUPage <> pageDefault
/\ getIndexOfAddr contextSaveAddr levelMin = idxCtxMMUPage
/\ isPE ctxMMUPage idxCtxMMUPage s
/\ entryPresentFlag ctxMMUPage idxCtxMMUPage true s
/\ entryUserFlag ctxMMUPage idxCtxMMUPage true s
