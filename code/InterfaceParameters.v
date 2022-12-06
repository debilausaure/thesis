From Pip.Model.Meta Require Import TypesModel StateModel StateAgnosticMonad.

Module Type InterfaceModel (Export Types : TypesModel)
                           (Export State : StateModel).

  Module SAMM := StateAgnosticMonad State.
  Export SAMM.
  (* Monad Interface *)

  Parameter setInterruptMask : interruptMask -> SAM unit.
  Parameter updateMMURoot : page -> SAM unit.
  Parameter updateCurPartition : page -> SAM unit.
  Parameter getInterruptMaskFromCtx : contextAddr -> SAM interruptMask.
  Parameter getMultiplexer : SAM page.
  Parameter page_eqb : page -> page -> SAM bool.
  Parameter noInterruptRequest : interruptMask -> SAM bool.
  Parameter loadContext : contextAddr -> bool -> SAM unit.

End InterfaceModel.
