Lemma childInPartTree (childPartDesc parentPartDesc : page)
                      (parentPageDir childLastMMUPage : page)
                      (s : state)
                      (nbL : level)
                      (childPartDescVAddr : vaddr)
                      (idxChildPartDesc : index) :
consistency s
-> Some nbL = getNbLevel
-> nextEntryIsPP parentPartDesc idxPageDir parentPageDir s
-> currentPartition s = parentPartDesc
-> isPE childLastMMUPage (getIndexOfAddr childPartDescVAddr levelMin) s
-> getTableAddrRoot childLastMMUPage idxPageDir
                    parentPartDesc childPartDescVAddr s
-> pageDefault <> childLastMMUPage
-> getIndexOfAddr childPartDescVAddr levelMin = idxChildPartDesc
-> isEntryPage childLastMMUPage idxChildPartDesc childPartDesc s
-> entryPresentFlag childLastMMUPage idxChildPartDesc true s
-> true = checkChild parentPartDesc nbL s childPartDescVAddr
-> In childPartDesc (getPartitions pageRootPartition s).
