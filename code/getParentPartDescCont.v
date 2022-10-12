Definition getParentPartDescCont (sourcePartDesc : page)
                                 (sourcePageDir : page)
                                 (targetInterrupt : index)
                                 (sourceContextSaveIndex : index)
                                 (nbL : level)
                                 (flagsOnYield : interruptMask)
                                 (flagsOnWake : interruptMask)
                                 (sourceInterruptedContext : contextAddr)
           : LLI yield_checks.
