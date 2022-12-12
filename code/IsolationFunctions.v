From Pip.Model.Meta Require Import TypesModel StateModel StateAgnosticMonad InterfaceModel.
From Pip.Model.Isolation Require Import IsolationTypes IsolationState.

Require Import Coq.Strings.String Lia NPeano.
Require Import Arith Bool List.
Import List.ListNotations.

Module IsolationInterface <: InterfaceModel IsolationTypes IsolationState.

  Module SAMM := StateAgnosticMonad IsolationState.
  Export SAMM.
  
  Definition setInterruptMask (mask : interruptMask) : SAM unit :=
    ret tt.
  
  Definition updateMMURoot(pageDir : page) : SAM unit :=
    ret tt.

  Definition updateCurPartition (p : page) : SAM unit :=
    modify (fun s => {| currentPartition := p; memory := s.(memory) |}).

  Definition getInterruptMaskFromCtx (context : contextAddr) : SAM interruptMask :=
  ret int_mask_d.

  Definition getPageRootPartition : LLI page :=
    ret pageRootPartition.

  Definition page_eqb (p1 : page) (p2 : page) : SAM bool :=
    ret (p1 =? p2).

  Definition noInterruptRequest (flags : interruptMask) : SAM bool :=
    ret true.

  Definition loadContext (contextToLoad : contextAddr)
                         (enforce_interrupt : bool) : SAM unit :=
    ret tt.

End IsolationInterface.
