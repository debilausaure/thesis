Definition checkCtxSaveIdxCont (targetPartDescVAddr : vaddr)
                               (targetInterrupt : index)
                               (userSourceContextSaveIndex : userValue)
                               (flagsOnYield : interruptMask)
                               (flagsOnWake : interruptMask)
                               (sourceInterruptedContext : contextAddr)
           : LLI yield_checks.
