Definition setInterruptMask (mask : interruptMask) : LLI unit :=
  ret tt.

Definition updateMMURoot(pageDir : page) : LLI unit :=
  ret tt.

Definition updateCurPartition (phyPartition : page) : LLI unit := 
  modify (fun s => 
    {| currentPartition := phyPartition ; memory := s.(memory) |}
  ).

Definition getInterruptMaskFromCtx (context : contextAddr)
           : LLI interruptMask :=
  ret int_mask_d.

Definition setInterruptMask (mask : interruptMask) : LLI unit :=
  ret tt.

Definition getPageRootPartition : LLI page :=
  ret pageRootPartition.

Definition page_eqb (p1 : page) (p2 : page) : SAM bool :=
  ret (p1 =? p2).

Definition noInterruptRequest (flags : interruptMask) : LLI bool :=
  ret true.

Definition loadContext (contextToLoad : contextAddr)
                       (enforce_interrupt : bool) : LLI unit :=
  ret tt.
