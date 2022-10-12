Definition checkIntLevelCont (targetPartDescVAddr : vaddr)
                             (userTargetInterrupt : userValue)
                             (userSourceContextSaveIndex : userValue)
                             (flagsOnYield : interruptMask)
                             (flagsOnWake : interruptMask)
                             (sourceInterruptedContext : contextAddr)
           : LLI yield_checks.
