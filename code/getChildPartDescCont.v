Definition getChildPartDescCont (sourcePartDesc : page)
                                (sourcePageDir : page)
                                (targetPartDescVAddr : vaddr)
                                (targetInterrupt : index)
                                (sourceContextSaveIndex : index)
                                (nbL : level)
                                (flagsOnYield : interruptMask)
                                (flagsOnWake : interruptMask)
                                (sourceInterruptedContext : contextAddr)
           : LLI yield_checks.