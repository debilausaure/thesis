Definition switchContextCont (targetPartDesc : page)
                             (targetPageDir  : page)
                             (flagsOnYield   : interruptMask)
                             (targetContext  : contextAddr)
                             : LLI yield_checks :=
  setInterruptMask flagsOnYield ;;
  updateMMURoot targetPageDir ;;
  updateCurPartition targetPartDesc ;;
  perform flagsOnWake := getInterruptMaskFromCtx targetContext in
  setInterruptMask flagsOnWake ;;
  (* allow root partition to prevent Pip from enforcing interrupts *)
  perform rootPartition := getPageRootPartition in
  perform targetReqNoInterrupt := noInterruptRequest flagsOnWake in
  (
  if (targetIsRoot && targetReqNoInterrupt)
  then
    loadContext targetContext false
  else
    loadContext targetContext true
  ) ;;
  (* Actually never reached *)
  ret SUCCESS.
